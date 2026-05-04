/**
 * ESP8266 WiFi舵机控制工程 — 纯API版
 * 版本：v2.0
 * 日期：2026-05-03
 * 描述：通过REST API控制SG90舵机，由Android App驱动
 *
 * API端点：
 *   GET /set?angle=N  设置舵机角度（0-180）
 *   GET /get          返回当前舵机角度
 *
 * 功能：
 *  - WiFi连接超时机制，超时后自动重启
 *  - WiFi断线自动重连（每5秒检测一次）
 *  - angle参数纯数字校验
 *  - 舵机PWM脉冲宽度校准
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

    server.on("/set", handleSetServo);
    server.on("/get", handleGetPosition);
    server.onNotFound(handleNotFound);
    server.begin();
    Serial.println("API server started!");
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
// REST API 端点
// ============================================================

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
