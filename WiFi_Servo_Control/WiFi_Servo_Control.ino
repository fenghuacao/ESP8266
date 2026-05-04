/**
 * ESP8266 WiFi舵机控制工程
 * 版本：v1.1 — Bug修复版本
 * 日期：2026-05-03
 * 描述：通过WiFi和电脑网页控制SG90舵机转动
 *
 * 修复内容：
 *  - WiFi连接添加超时机制，超时后自动重启
 *  - WiFi断线自动重连（每5秒检测一次）
 *  - 网页滑块添加100ms防抖，避免压垮ESP8266
 *  - angle参数添加纯数字校验，杜绝非法值
 *  - HTML使用PROGMEM存储在Flash，节省RAM
 *  - HTML格式化分行为可读结构
 */

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Servo.h>

// WiFi配置
#define WIFI_SSID "别睡了"
#define WIFI_PASSWORD "buyaocengwifi"

// 硬件配置
#define SERVO_PIN 2          // 舵机信号引脚（D4 = GPIO2）

// 舵机PWM脉冲宽度校准（SG90典型范围：500~2500µs）
#define SERVO_PULSE_MIN 500
#define SERVO_PULSE_MAX 2500

// WiFi连接超时（最多尝试40次 × 500ms = 20秒）
#define WIFI_TIMEOUT 40

// 全局对象和变量
ESP8266WebServer server(80);
Servo myServo;
int servoPosition = 90;      // 舵机当前位置，初始90°

// ============================================================
// HTML控制页面模板 — 存储在Flash中（PROGMEM），不占RAM
// 使用 {POS} 和 {IP} 作为动态占位符
// ============================================================
const char HTML_TEMPLATE[] PROGMEM = R"rawliteral(
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ESP8266 Servo</title>
<style>
body{font-family:Arial;margin:40px;background:#f5f5f5;}
.container{max-width:800px;margin:0 auto;background:white;padding:40px;border-radius:10px;}
h1{color:#333;text-align:center;}
.pos{text-align:center;font-size:64px;font-weight:bold;color:#007bff;}
.slider{width:100%;height:25px;}
.buttons{display:flex;justify-content:center;gap:10px;margin:20px 0;}
.btn{padding:10px 20px;font-size:16px;font-weight:bold;border:none;border-radius:5px;cursor:pointer;background:#007bff;color:white;}
.manual{margin:20px 0;padding:20px;background:#f8f9fa;border-radius:5px;}
.input{padding:10px;font-size:16px;width:100px;text-align:center;}
.version{text-align:center;color:#666;font-size:12px;margin-top:20px;padding-top:20px;border-top:1px solid #e9ecef;}
</style>
</head>
<body>
<div class='container'>
<h1>ESP8266 Servo Controller</h1>
<div class='pos'>Position: <span id='pos'>{POS}</span>&deg;</div>
<input type='range' class='slider' id='slider' min='0' max='180' value='{POS}'>
<div class='buttons'>
<button class='btn' onclick='moveInstant(0)'>0&deg;</button>
<button class='btn' onclick='moveInstant(45)'>45&deg;</button>
<button class='btn' onclick='moveInstant(90)'>90&deg;</button>
<button class='btn' onclick='moveInstant(135)'>135&deg;</button>
<button class='btn' onclick='moveInstant(180)'>180&deg;</button>
</div>
<div class='manual'>
<h3>Manual Input</h3>
<input type='number' class='input' id='manual' min='0' max='180' placeholder='0-180'>
<button class='btn' onclick='sendManual()'>Send</button>
</div>
<div style='text-align:center;color:#666;margin-top:20px;'>IP: {IP}</div>
<div class='version'>Version: v1.1 | Date: 2026-05-03</div>
</div>
<script>
// 防抖定时器（仅用于滑块拖拽）
var debounceTimer = null;

// 发送HTTP请求到ESP8266
function sendAngle(angle) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/set?angle=' + angle, true);
  xhr.send();
}

// 预设按钮 / 手动输入 → 立即发送（不经debounce）
function moveInstant(angle) {
  document.getElementById('pos').textContent = angle;
  document.getElementById('slider').value = angle;
  document.getElementById('manual').value = angle;
  if (debounceTimer) clearTimeout(debounceTimer);
  sendAngle(angle);
}

// 滑块拖拽 → 带100ms防抖
function moveDebounced(angle) {
  document.getElementById('pos').textContent = angle;
  document.getElementById('manual').value = angle;
  if (debounceTimer) clearTimeout(debounceTimer);
  debounceTimer = setTimeout(function() { sendAngle(angle); }, 100);
}

function sendManual() {
  var angle = document.getElementById('manual').value;
  if (angle >= 0 && angle <= 180) {
    moveInstant(angle);
  } else {
    alert('Please enter 0-180');
  }
}
document.getElementById('slider').oninput = function() { moveDebounced(this.value); };
document.getElementById('manual').onkeypress = function(e) {
  if (e.key == 'Enter') sendManual();
};
</script>
</body>
</html>
)rawliteral";

// ============================================================
// setup()
// ============================================================
void setup() {
  Serial.begin(115200);
  myServo.attach(SERVO_PIN, SERVO_PULSE_MIN, SERVO_PULSE_MAX);
  myServo.write(servoPosition);

  // WiFi连接 — 带超时机制，超时后重启
  Serial.print("Connecting to WiFi");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  int attempts = 0;
  while (WiFi.status() != WL_CONNECTED && attempts < WIFI_TIMEOUT) {
    delay(500);
    Serial.print(".");
    attempts++;
  }

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("");
    Serial.println("WiFi connected!");
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());

    server.on("/", handleRoot);
    server.on("/set", handleSetServo);
    server.on("/get", handleGetPosition);
    server.onNotFound(handleNotFound);
    server.begin();
    Serial.println("Web server started!");
  } else {
    Serial.println("");
    Serial.println("WiFi connection failed! Rebooting in 3 seconds...");
    delay(3000);
    ESP.restart();
  }
}

// ============================================================
// loop() — 主循环
// ============================================================
void loop() {
  // 每5秒检测WiFi状态，断线自动重连
  static unsigned long lastWifiCheck = 0;
  if (millis() - lastWifiCheck > 5000) {
    lastWifiCheck = millis();
    if (WiFi.status() != WL_CONNECTED) {
      Serial.println("WiFi disconnected! Reconnecting...");
      WiFi.reconnect();
    }
  }

  server.handleClient();
}

// ============================================================
// HTTP请求处理函数
// ============================================================

// GET / — 返回控制页面
void handleRoot() {
  String html = FPSTR(HTML_TEMPLATE);
  html.replace("{POS}", String(servoPosition));
  html.replace("{IP}", WiFi.localIP().toString());
  server.send(200, "text/html; charset=UTF-8", html);
}

// GET /set?angle=N — 设置舵机角度
void handleSetServo() {
  if (!server.hasArg("angle")) {
    server.send(400, "text/plain", "Missing angle");
    return;
  }

  String angleStr = server.arg("angle");

  // 校验：参数不能为空
  if (angleStr.length() == 0) {
    server.send(400, "text/plain", "Empty angle parameter");
    return;
  }

  // 校验：参数必须为纯数字（避免 "abc" 被 toInt() 误转为 0）
  for (size_t i = 0; i < angleStr.length(); i++) {
    if (!isDigit(angleStr.charAt(i))) {
      server.send(400, "text/plain", "Invalid angle parameter (must be numeric)");
      return;
    }
  }

  int angle = angleStr.toInt();

  if (angle >= 0 && angle <= 180) {
    servoPosition = angle;
    myServo.write(servoPosition);
    Serial.print("Set angle: ");
    Serial.println(angle);
    server.send(200, "text/plain", "OK");
  } else {
    server.send(400, "text/plain", "Angle out of range (0-180)");
  }
}

// GET /get — 返回当前角度
void handleGetPosition() {
  server.send(200, "text/plain", String(servoPosition));
}

// 404
void handleNotFound() {
  server.send(404, "text/plain", "Not Found");
}
