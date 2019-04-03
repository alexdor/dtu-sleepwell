#include "DHT.h"
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include <WiFiClientSecureBearSSL.h>

#define DHTPIN 2     // what digital pin the DHT22 is conected to
#define DHTTYPE DHT22   // there are multiple kinds of DHT sensors


const char* WIFI_SSID = "Just passing along";
const char* WIFI_PASS = "!!!GemistaGiati_misoumeJava!!!";

DHT dht(DHTPIN, DHTTYPE);



void wifiConnect() {

  // Connecting to WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(WIFI_SSID);

  // ---------------This was the magic WiFi reconnect fix for me https://github.com/esp8266/Arduino/issues/2186
  WiFi.persistent(false);
  WiFi.mode(WIFI_OFF);   // this is a temporary line, to be removed after SDK update to 1.5.4
  WiFi.mode(WIFI_STA);
  // ---------------END - WiFi reconnect fix

  WiFi.begin(WIFI_SSID, WIFI_PASS);

  unsigned long wifiConnectStart = millis();

  while (WiFi.status() != WL_CONNECTED) {
    // Check to see if
    if (WiFi.status() == WL_CONNECT_FAILED) {
      Serial.println("Failed to connect to WIFI. Please verify credentials: ");
      Serial.println();
      Serial.print("SSID: ");
      Serial.println(WIFI_SSID);
      Serial.print("Password: ");
      Serial.println(WIFI_PASS);
      Serial.println();
    }

    delay(500);
    Serial.println("...");
    // Only try for 5 seconds.
    if (millis() - wifiConnectStart > 5000) {
      Serial.println("Failed to connect to WiFi");
      Serial.println("Please attempt to send updated configuration parameters.");
      return;
    }
  }
  Serial.println("");
  Serial.println("WiFi connected");
}


void setup() {
  Serial.begin(9600);
  Serial.setTimeout(2000);


  // Wait for serial to initialize.
  while (!Serial) { }

  dht.begin();

  wifiConnect();
  Serial.println("Device Started");
  Serial.println("-------------------------------------");
  Serial.println("Running DHT!");
  Serial.println("-------------------------------------");

}

void sendMessage(double humidity, double temp, double heatIndex) {
  BearSSL::WiFiClientSecure client;
  client.setInsecure();
  HTTPClient https;

  https.begin(client, "quomodo.serveo.ne", 443, "/esp");    //Specify request destination
  https.addHeader("Content-Type", "text/json");  //Specify content-type header
  StaticJsonDocument<500> jsonBuffer;

  jsonBuffer["humidity"] = humidity;
  jsonBuffer["temp"] = temp;
  jsonBuffer["heatIndex"] = heatIndex;

  String msg;
  serializeJson(jsonBuffer, msg);
  int httpCode = https.POST(msg);   //Send the request
  String payload = https.getString();                  //Get the response payload

  Serial.print("http code:");
  Serial.println(httpCode);   //Print HTTP return code
  Serial.print("payload:");
  Serial.println(payload);    //Print request response payload

  https.end();  //Close connection
}

int timeSinceLastRead = 0;


void loop() {

  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("Disconnected from WiFi");
    wifiConnect();
  }


  // Report every 2 seconds.
  if (timeSinceLastRead > 2000) {
    // Reading temperature or humidity takes about 250 milliseconds!
    // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
    float h = dht.readHumidity();
    // Read temperature as Celsius (the default)
    float t = dht.readTemperature();

    // Check if any reads failed and exit early (to try again).
    if (isnan(h) || isnan(t)) {
      Serial.println("Failed to read from DHT sensor!");
      Serial.printf("h: %d, t: %d \n", isnan(h), isnan(t));
      timeSinceLastRead = 0;
      return;
    }

    // Compute heat index in Celsius (isFahreheit = false)
    float hic = dht.computeHeatIndex(t, h, false);




    Serial.print("Humidity: ");
    Serial.print(h);
    Serial.print(" %\t");
    Serial.print("Temperature: ");
    Serial.print(t);
    Serial.print(" *C ");
    Serial.print("Heat index: ");
    Serial.print(hic);
    Serial.print(" *C ");
    Serial.println("");

    sendMessage(h, t, hic);

    timeSinceLastRead = 0;
  }
  delay(100);
  timeSinceLastRead += 100;
}
