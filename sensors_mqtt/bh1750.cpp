#include <ArduinoJson.h>
#include <Wire.h>
#include <BH1750.h>
#include <WiFi.h>
#include <PubSubClient.h>

// WiFi credentials
const char* ssid = "xxx";
const char* password = "xxx";
const char* mqtt_server = "xxx";

// MQTT client
WiFiClient espClient;
PubSubClient client(espClient);

long lastMsg = 0;
BH1750 lightMeter;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  if (!lightMeter.begin()) {
    Serial.println("Could not find BH1750 sensor!");
    while (1);
  }

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
    float lux = lightMeter.readLightLevel();

    StaticJsonDocument<50> doc;
    char output[50];

    doc["lux"] = lux;
    serializeJson(doc, output);

    Serial.println(output);
    client.publish("/home/sensors/bh1750", output);
  }
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    String clientId = "ESP32BH1750-";
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
