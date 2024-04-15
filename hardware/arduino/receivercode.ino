#include <ESP32Servo.h>
#include "CytronMotorDriver.h"

int stepDelay = 1500;
int pos = 115;
int servoPin = 23;
Servo myservo;
bool isAutomatic = false;

const int stepsPerRevolution = 200;  // Change this based on your stepper motor
const int stepPin = 19;              // Step pin on A4988 connected to GPIO 14
const int dirPin = 18;               // Direction pin on A4988 connected to GPIO 12
const int stepPin2 = 5;              // Step pin on A4988 connected to GPIO 14
const int dirPin2 = 4;
const int stepPin3 = 2;  // Step pin on A4988 connected to GPIO 14
const int dirPin3 = 15;

const int pumpPin = 22;

String autoModeDir = "";

void forward();
void backward();
void lefts();
void rights();
void right();
void left();
void stop();
void plateUp();
void plateDown();
void servoOpen();
void servoClose();



#include <Arduino.h>
#include <WiFi.h>
#include <FirebaseESP32.h>
// Provide the token generation process info.
#include <addons/TokenHelper.h>
// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>
/* 1. Define the WiFi credentials */
#define WIFI_SSID "Autobonics_4G"
#define WIFI_PASSWORD "autobonics@27"
// For the following credentials, see examples/Authentications/SignInAsUser/EmailPassword/EmailPassword.ino
/* 2. Define the API Key */
#define API_KEY "AIzaSyAFZ7BFjZiPTuJ3vsK9-60MJQNOyzZ_dNo"
/* 3. Define the RTDB URL */
#define DATABASE_URL "https://scrubster-625ae-default-rtdb.firebaseio.com/"
//<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app
/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "device@gmail.com"
#define USER_PASSWORD "12345678"
// Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
unsigned long sendDataPrevMillis = 0;
// Variable to save USER UID
String uid;
//Databse
String path;





FirebaseData stream;
void streamCallback(StreamData data) {
  Serial.println("NEW DATA!");

  String p = data.dataPath();

  Serial.println(p);
  printResult(data);  // see addons/RTDBHelper.h

  FirebaseJson jVal = data.jsonObject();
  FirebaseJsonData direction;
  FirebaseJsonData isAuto;
  FirebaseJsonData stepper1;
  FirebaseJsonData stepper2;


  jVal.get(direction, "direction");
  jVal.get(isAuto, "isAuto");
  jVal.get(stepper1, "stepper1");
  jVal.get(stepper2, "stepper2");

  if (direction.success) {
    Serial.println("Success data direciton");
    String value = direction.to<String>();
    if (value == "f") {
      forward();
    }
    if (value == "b") {
      backward();
    }
    if (value == "l") {
      lefts();
    }
    if (value == "r") {
      rights();
    }
    if (value == "rr") {
      right();
    }
    if (value == "lr") {
      left();
    }
    if (value == "s") {
      stop();
    }
  }
  if (isAuto.success) {
    Serial.println("Succes data is automatic");
    bool value = isAuto.to<bool>();
      isAutomatic = value;
  }

  if (stepper1.success) {
    Serial.println("Success data direciton");
    String value = stepper1.to<String>();
    if (value == "u") {
      plateUp();
    }
    if (value == "d") {
      plateDown();
    }
  } 

  if (stepper2.success) {
    Serial.println("Success data direciton");
    String value = stepper2.to<String>();
    if (value == "u") {
      servoOpen();
    }
    if (value == "d") {
      servoClose();
    }
  }
}

void streamTimeoutCallback(bool timeout) {
  if (timeout)
    Serial.println("stream timed out, resuming...\n");

  if (!stream.httpConnected())
    Serial.printf("error code: %d, reason: %s\n\n", stream.httpCode(), stream.errorReason().c_str());
}



// Configure the motor driver.
CytronMD motor1(PWM_DIR, 12, 13);  // PWM 1 = Pin 3, DIR 1 = Pin 4.
CytronMD motor2(PWM_DIR, 27, 14);  // PWM 2 = Pin 9, DIR 2 = Pin 10.
CytronMD motor3(PWM_DIR, 25, 26);  // PWM 2 = Pin 9, DIR 2 = Pin 10.
CytronMD motor4(PWM_DIR, 32, 33);
void setup() {
  myservo.attach(servoPin);
  myservo.write(pos);
  pinMode(stepPin, OUTPUT);
  pinMode(dirPin, OUTPUT);
  pinMode(stepPin2, OUTPUT);
  pinMode(dirPin2, OUTPUT);
  pinMode(stepPin3, OUTPUT);
  pinMode(dirPin3, OUTPUT);
  Serial.begin(115200);                       // Begin serial communication with the PC
  Serial2.begin(115200, SERIAL_8N1, 16, 17);  // Begin serial communication with the Arduino Mega

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  unsigned long ms = millis();
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  //FIREBASE
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);
  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback;  // see addons/TokenHelper.h

  // Limit the size of response payload to be collected in FirebaseData
  fbdo.setResponseSize(2048);

  Firebase.begin(&config, &auth);

  // Comment or pass false value when WiFi reconnection will control by your code or third party library
  Firebase.reconnectWiFi(true);

  Firebase.setDoubleDigits(5);

  config.timeout.serverResponse = 10 * 1000;

  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  // Print user UID
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);

  path = "devices/" + uid + "/reading";




  //Stream setup
  if (!Firebase.beginStream(stream, "devices/" + uid + "/data"))
    Serial.printf("sream begin error, %s\n\n", stream.errorReason().c_str());

  Firebase.setStreamCallback(stream, streamCallback, streamTimeoutCallback);
}

  void updateData() {
    if (Firebase.ready() && (millis() - sendDataPrevMillis > 500 || sendDataPrevMillis == 0)) {
      sendDataPrevMillis = millis();
      FirebaseJson json;
      json.set(F("ts/.sv"), F("timestamp"));
      Serial.printf("Set data with timestamp... %s\n", Firebase.setJSON(fbdo, path.c_str(), json) ? fbdo.to<FirebaseJson>().raw() : fbdo.errorReason().c_str());
      Serial.println("");
    }
  }



void left() {
  motor1.setSpeed(-255);  // Motor 1 runs backward at full speed.
  motor2.setSpeed(-255);  // Motor 2 runs forward at full speed.
  motor3.setSpeed(255);   // Motor 2 runs forward at full speed.
  motor4.setSpeed(255);
}

void right() {
  motor1.setSpeed(255);   // Motor 1 runs backward at full speed.
  motor2.setSpeed(255);   // Motor 2 runs forward at full speed.
  motor3.setSpeed(-255);  // Motor 2 runs forward at full speed.
  motor4.setSpeed(-255);
}
void forward() {
  motor1.setSpeed(-255);  // Motor 1 runs backward at full speed.
  motor2.setSpeed(-255);  // Motor 2 runs forward at full speed.
  motor3.setSpeed(-255);  // Motor 2 runs forward at full speed.
  motor4.setSpeed(-255);
}
void backward() {
  motor1.setSpeed(255);  // Motor 1 runs forward at 50% speed.
  motor2.setSpeed(255);  // Motor 2 runs backward at 50% speed.
  motor3.setSpeed(255);  // Motor 2 runs backward at 50% speed.
  motor4.setSpeed(255);
}
void lefts() {
  motor1.setSpeed(255);   // Motor 1 runs backward at full speed.
  motor2.setSpeed(-255);  // Motor 2 runs forward at full speed.
  motor3.setSpeed(-255);  // Motor 2 runs forward at full speed.
  motor4.setSpeed(255);
}
void rights() {
  motor1.setSpeed(-255);  // Motor 1 runs backward at full speed.
  motor2.setSpeed(255);   // Motor 2 runs forward at full speed.
  motor3.setSpeed(255);   // Motor 2 runs forward at full speed.
  motor4.setSpeed(-255);
}

void stop() {
  motor1.setSpeed(0);  // Motor 1 runs backward at full speed.
  motor2.setSpeed(0);  // Motor 2 runs forward at full speed.
  motor3.setSpeed(0);  // Motor 2 runs forward at full speed.
  motor4.setSpeed(-0);
}

void plateUp() {
  stepPlate(stepDelay, 2 * stepsPerRevolution, LOW);
}

void plateDown() {
  stepPlate(stepDelay, 2 * stepsPerRevolution, HIGH);
}


void servoOpen() {
  while (pos > 45) {
    threadOpen();
    pos = max(pos - 20, 45);
    myservo.write(pos);
    delay(300);
  }
}
void servoClose() {
  while (pos < 135) {
    pos = min(pos + 25, 135);
    myservo.write(pos);
    threadClose();
    delay(150);
  }
}
void pump() {
  for (int i = 0; i < 2; i++) {
    digitalWrite(pumpPin, HIGH);
    delay(1000);
    digitalWrite(pumpPin, LOW);
    delay(500);
  }
}

void threadOpen() {
  stepThread(stepDelay, 2 * stepsPerRevolution, LOW);
}

void threadClose() {
  stepThread(stepDelay, 2 * stepsPerRevolution, HIGH);
}

void stepPlate(int stepDelay, int steps, int dir) {
  // Set the direction
  digitalWrite(dirPin, dir);
  digitalWrite(dirPin3, dir);

  // Step the motor
  for (int i = 0; i < abs(steps); ++i) {
    digitalWrite(stepPin, HIGH);
    digitalWrite(stepPin3, HIGH);
    delayMicroseconds(stepDelay);
    digitalWrite(stepPin, LOW);
    digitalWrite(stepPin3, LOW);
    delayMicroseconds(stepDelay);
  }
}
void stepThread(int stepDelay, int steps, int dir) {
  digitalWrite(dirPin2, dir);
  for (int i = 0; i < abs(steps); ++i) {
    digitalWrite(stepPin2, HIGH);
    delayMicroseconds(stepDelay);
    digitalWrite(stepPin2, LOW);
    delayMicroseconds(stepDelay);
  }
}
void clean() {
  plateUp();
  pump();
  servoOpen();
  plateDown();
  servoClose();
}

void loop() {
  updateData();
  if (isAutomatic == true) {
    Serial.println("Automatic mode turned on");
    if (Serial2.available()) {                  // Check if data is available to read from Arduino Mega
      int dataReceived = Serial2.read() - '0';  // Convert ASCII character to numerical value

      // Process the received data
      // For example, you can print it to the Serial Monitor
      Serial.println("Data received from Arduino Mega:");
      Serial.println(dataReceived);
      if (dataReceived == 0) {
        stop();
      } else if (dataReceived == 1) {
        forward();
      } else if (dataReceived == 2) {
        right();
      } else if (dataReceived == 3) {
        left();
      } else if (dataReceived == 4) {
        clean();
      } else if (dataReceived == 5) {
        rights();
      }
      else if (dataReceived == 6) {
        lefts();
      }else{
        stop();
      }
    }else{
      Serial.println("No serial data has been recieved");
    }
    Serial2.flush();
  }
}
