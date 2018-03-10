//include liraria Servo
#include <Servo.h>. 
//definirea pinilor Tirg si Echo al senzorului Ultrasonic
const int trigPin = 10;
const int echoPin = 11;
//variabilele petru timp si distanta
long duration;
int distance;
Servo myServo;//crearea unui obiect de tip Servo pentru controlul servomotorului
void setup()
{
  pinMode(trigPin, OUTPUT);//setarea lui trigPin ca un Output
  pinMode(echoPin, INPUT);//setarea lui echoPin ca un Input
  Serial.begin(64000);
  myServo.attach(12);//definirea pinului pe care atasam servomotorul
}
void loop()
{
  //definex axa de rotatie a servomotorului de la 0 la 180 de grade
  for(int i=0;i<=180;i++)
  {  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();//apelarea functiei de calculare a distantei masuratede senzorul ultrasonic pentru fiecare grad
  Serial.print(i);//trimit gradul curent in portul Serial 
  Serial.print(",");//trimit un caracter aditional langa i pentru folosirea ulterioara in indexarea din Processing IDE
  Serial.print(distance);//trimit distanta in portul Serial
  Serial.print(".");//trimit un caracter aditional langa distance pentru folosirea ulterioara in indexarea din Processing IDE
  }
  //repet procesul pentru 180 pana la 0 grade
  for(int i=180;i>0;i--)
  {  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
  }
}
//functia de calculare a distantei masurate de senzorul ultrasonic
int calculateDistance()
{  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  //setez trigPin pe High pentru 10 milisecunde
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);//citeste din echoPin timpul parcurs de sunet in milisecunde
  distance= duration*0.034/2;
  return distance;
}

