/**
 * ESP8266 WiFi舵机控制工程 — AP直连版
 * 版本：v2.1
 * 日期：2026-05-03
 * 描述：ESP8266创建WiFi热点，手机直连控制SG90舵机
 *
 * AP信息：
 *   SSID: ESP8266-Servo
 *   密码: 12345678
 *   IP:   192.168.4.1
 *
 * API端点：
 *   GET /set?angle=N  设置舵机角度（0-180）
 *   GET /get          返回当前舵机角度
 *
 * 功能：
 *  - 舵机PWM脉冲宽度校准
 *  - angle参数纯数字校验
 */

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Servo.h>

// AP配置（手机WiFi列表中找到此名称连接）
#define AP_SSID "ESP8266-Servo"
#define AP_PASSWORD "12345678"

// 硬件配置
#define SERVO_PIN 2          // 舵机信号引脚（D4 = GPIO2）

// 舵机PWM脉冲宽度校准（SG90典型范围：500~2500µs）
#define SERVO_PULSE_MIN 500
#define SERVO_PULSE_MAX 2500

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

  // 创建WiFi热点
  WiFi.mode(WIFI_AP);
  WiFi.softAP(AP_SSID, AP_PASSWORD);

  Serial.println("");
  Serial.print("AP started: ");
  Serial.println(AP_SSID);
  Serial.print("AP IP: ");
  Serial.println(WiFi.softAPIP());

  server.on("/set", handleSetServo);
  server.on("/get", handleGetPosition);
  server.onNotFound(handleNotFound);
  server.begin();
  Serial.println("API server started!");
}

// ============================================================
// loop() — 主循环
// ============================================================
void loop() {
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
