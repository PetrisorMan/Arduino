#define NUMREADINGS 15 // raise this number to increase data smoothing

int senseLimit = 15;  // raise this number to decrease sensitivity (up to 1023 max)
int probePin = A5;     // analog 5
int val = 0;          // reading from probePin
                      // connections to LED bargraph anodes with resistors in series
int LED1 = 2;
int LED2 = 3;
int LED3 = 4;
int LED4 = 5;
int LED5 = 6;
int LED6 = 7;
int LED7 = 8;
int LED8 = 9;
// variables for smoothing
int readings[NUMREADINGS];                // the readings from the analog input
int index = 0;                            // the index of the current reading
int total = 0;                            // the running total
int average = 0;                          // final average of the probe reading

void setup()
{
  pinMode(2, OUTPUT);  // specify LED bargraph outputs
  pinMode(3, OUTPUT); 
  pinMode(4, OUTPUT); 
  pinMode(5, OUTPUT); 
  pinMode(6, OUTPUT); 
  pinMode(7, OUTPUT); 
  pinMode(8, OUTPUT); 
  pinMode(9, OUTPUT); 
  Serial.begin(9600);                   // initiate serial connection for debugging/etc
  for (int i = 0; i < NUMREADINGS; i++) // initialize all the readings to 0
    readings[i] = 0;
}

void loop() 
{
  val = analogRead(probePin);  // take a reading from the probe
  if(val >= 1)
  {                            // if the reading isn't zero, proceed
    val = constrain(val, 1, senseLimit);      // turn any reading higher than the senseLimit value into the senseLimit value
    val = map(val, 1, senseLimit, 1, 1023);  // remap the constrained value within a 1 to 1023 range

    total -= readings[index];               // subtract the last reading
    readings[index] = val;                  // read from the sensor
    total += readings[index];               // add the reading to the total
    index = (index + 1);                    // advance to the next index

    if (index >= NUMREADINGS)               // if we're at the end of the array
      index = 0;                            // wrap around to the beginning
    average = total / NUMREADINGS;          // calculate the average

    if (average > 50){                // if the average is over 50
      digitalWrite(LED1, HIGH);       // light the first LED
    }
    else{                             // and if it's not turn that LED off
      digitalWrite(LED1, LOW);
    }

    if (average > 150){               // and so on
      digitalWrite(LED2, HIGH);
    }
    else{
      digitalWrite(LED2, LOW);
    }

    if (average > 250){
      digitalWrite(LED3, HIGH);
    }
    else{
      digitalWrite(LED3, LOW);
    }

    if (average > 350){
      digitalWrite(LED4, HIGH);
    }
    else{
      digitalWrite(LED4, LOW);
    }

    if (average > 450){
      digitalWrite(LED5, HIGH);
    }
    else{
      digitalWrite(LED5, LOW);
    }

    if (average > 550){
      digitalWrite(LED6, HIGH);
    }
    else{
      digitalWrite(LED6, LOW);
    }

    if (average > 650){
      digitalWrite(LED7, HIGH);
    }
    else{
      digitalWrite(LED7, LOW);
    }

    if (average > 750){
      digitalWrite(LED8, HIGH);
    }
    else{
      digitalWrite(LED8, LOW);
    }

    Serial.println(val);   // use output to aid in calibrating
  }
}

