#include <ArduinoJson.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include "MHZ19.h"
#include <SoftwareSerial.h>

// WiFi credentials
const char* ssid = "xxx";
const char* password = "xxx";
const char* mqtt_server = "xxx";

// MQTT client
WiFiClient espClient;
PubSubClient client(espClient);

long lastMsg = 0;

// MH-Z19 CO2 sensor
SoftwareSerial mySerial(16, 17); // RX, TX pins (change if needed)
MHZ19 myMHZ19;
int CO2;

void setup() {
  Serial.begin(115200);
  mySerial.begin(9600);
  myMHZ19.begin(mySerial);

  // Connect to WiFi
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
  Serial.println(WiFi.localIP());

  client.setServer(mqtt_server, 1883);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }

  long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;

    CO2 = myMHZ19.getCO2();
    StaticJsonDocument<50> doc;
    char output[50];

    doc["co2"] = CO2;
    serializeJson(doc, output);

    Serial.println(output);
    client.publish("/home/sensors/mhz19", output);
  }
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    String clientId = "ESP32MHZ19-";
    clientId += String(random(0xffff), HEX);
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      delay(5000);
    }
  }
}
