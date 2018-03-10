const int analogPin = A1; // the pin that the potentiometer is attached to
const int ledCount = 8; // the number of LEDs in the bar graph
int ledPins[] = {2, 3, 4, 5, 6, 7, 8, 9}; // an array of pin numbers to which LEDs are attached

void setup() {
   for (int thisLed = 0; thisLed < ledCount; thisLed++) {
      pinMode(ledPins[thisLed], OUTPUT);
   }
}

void loop() {
   int sensorReading = analogRead(analogPin);
   int ledLevel = map(sensorReading, 0, 1023, 0, ledCount);
   for (int thisLed = 0; thisLed < ledCount; thisLed++) {
      if (thisLed < ledLevel) {
         digitalWrite(ledPins[thisLed], HIGH);
      }else { // turn off all pins higher than the ledLevel:
         digitalWrite(ledPins[thisLed], LOW);
      }
   }
} 
