#include <ESP8266WiFi.h>
#include <ArduinoJson.h>
#include <Arduino.h>
#include <Firebase_ESP_Client.h>
#include "time.h"
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#define API_KEY "AIzaSyAGDClS7C4rYoVs77kDlcs5gPLPL-_7nNw"
#define USER_EMAIL "duetinmehedishuvo@gmail.com"
#define USER_PASSWORD "123456"
#define DATABASE_URL "solar-power-aerator-for-79b02-default-rtdb.firebaseio.com"
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String uid;
// Database main path (to be updated in setup with the user UID)
String databasePath;
FirebaseJson json;
// Database child nodes
String mainPath = "/INTACT_POWER/device_1";

const char* ntpServer = "pool.ntp.org";
unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 180000;

//server status led
#define BlynkLED D5
//buttons and led pins
#define btn1 D1
#define led1 D7
//led states
bool led1State = false;

//Wifi config
const char* ssid = "shuvo";
const char* password = "shuvo654123";

int connectStatus = 0;
int statusChange = 0;

void firebaseSetup() {

  configTime(0, 0, ntpServer);
  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.database_url = DATABASE_URL;
  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(4096);
  config.token_status_callback = tokenStatusCallback;
  config.max_token_generation_retry = 10;
  Firebase.begin(&config, &auth);
  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(2000);
  }
}

bool signupOK = false;

void firebaseGuestToken() {
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("ok");
    signupOK = true;
  }
  else {
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }
  config.token_status_callback = tokenStatusCallback;
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}


void setup()
{

  Serial.begin(115200);

  pinMode(BlynkLED, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(btn1, INPUT_PULLUP);

  // Connect to WiFi
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting...");
  }
  Serial.println("Connected to WiFi");

  connectStatus = 1;
  statusChange = 0;
  firebaseSetup();
}

void loop()
{

  // Check if WiFi connection is still active
  if (WiFi.status() != WL_CONNECTED) {
    connectStatus = 0;
    Serial.println("WiFi connection lost.");
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
      whenOffline();
      Serial.println("Reconnecting...");
    }

  } else {
    connectStatus += 1;
    if (connectStatus == 1) {
      firebaseSetup();
    }
    whenOnline(); //handles online functionalities
  }
}

void whenOnline()
{
  statusChange++;

  if (Firebase.isTokenExpired()) {
    Firebase.refreshToken(&config);
    Serial.println("Refresh token");
  }

  if (digitalRead(btn1) == LOW)
  {
    led1State = !led1State;
    updateLEDs();
    delay(50);
    while (digitalRead(btn1) == LOW);

    int ststtt = 0;
    if (led1State == true) {
      ststtt = 1;
    }

    if (Firebase.RTDB.setInt(&fbdo, mainPath, ststtt)) {
//      Serial.println("Successfully SAVE TO " + fbdo.dataPath() + " (" + fbdo.dataType() + ")");
    } else {
      Serial.println("FAILED : Update \n" + fbdo.errorReason());
    }
  }

  if (Firebase.RTDB.getInt(&fbdo, mainPath)) {
    int analogValue =  fbdo.intData();
    if (analogValue == 1) {
      led1State = true;
    } else {
      led1State = false;
    }

    updateLEDs();
    delay(50);

  } else {
    Serial.println("FAILED : Data Received \n" + fbdo.errorReason());
  }

}

void whenOffline()
{
  if (digitalRead(btn1) == LOW)
  {
    led1State = !led1State;
    updateLEDs();
    delay(50);
    while (digitalRead(btn1) == LOW);
  }
}

void updateLEDs()
{
  digitalWrite(led1, led1State);
}