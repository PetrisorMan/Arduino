import processing.serial.*;//importeaza libraria pentru comunicarea cu serialul
import java.awt.event.KeyEvent; //importeaza libraria pentru citirea datelor din portul serial 
import java.io.IOException;
import processing.sound.*;//importeaza libraria pentru comunicarea cu sunetul de pe laptop
SoundFile file;//crearea unui obiect de tip sunet pentru lucru
Serial myPort;//crearea unui obiect de tip serial pentru lucru
//definire variabile
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;

void setup() 
{
  file = new SoundFile(this, "C:\\Users\\Boris\\Desktop\\proces_radar\\Sonar Radar Sound Effect.mp3");
  file.play();
  file.stop();
  file.loop();
 size (1280, 720);//crearea unei ferestre pentru rezolutia selectata
 smooth();
 myPort = new Serial(this,"COM3", 64000);//incepe comunicarea cu serialul
 myPort.bufferUntil('.');//citeste pana la intalnirea caracterului '.'.Datele sunt de forma "unghi,distanta.
}
void draw()
{
  fill(98,245,31);//umplerea cu culoarea verde
  //simularea miscarii si disparitia linilor
  noStroke();
  fill(0,4); 
  rect(0, 0, width, height-height*0.065); 
  fill(98,245,31);
  //apelarea functiilor de desenare a radarului
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}
void serialEvent (Serial myPort) 
{ 
  //citeste datele din port pana la '.' si le pune in variabila data
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(",");//gasim ',' si o punem in variabila index1
  angle= data.substring(0, index1);//citirea datelor de la 0 la index1=valoarea unghiului
  distance= data.substring(index1+1, data.length());//citirea datelor de la index1+1 pana la final=valoarea distantei
  //transformam datele in numere intregi
  iAngle = int(angle);
  iDistance = int(distance);
}
void drawRadar() 
{
  pushMatrix();
  translate(width/2,height-height*0.074);//mutarea coordonatelor initiale in alta locatie
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  //desenarea linilor de arce
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  //desenarea linilor la unghiuri
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();
}
void drawObject() 
{
  pushMatrix();
  translate(width/2,height-height*0.074);
  strokeWeight(9);
  stroke(255,10,10);//culoarea rosu
  pixsDistance = iDistance*((height-height*0.1666)*0.025);//conversia datelor de la senzor din cm in pixeli
  //limitarea valorilor citite pana la 40 de cm
  if(iDistance<40){
  //desenarea obiectului corespunzator unghiului si distantei
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(width-width*0.505)*cos(radians(iAngle)),-(width-width*0.505)*sin(radians(iAngle)));
  }
  popMatrix();
}
void drawLine() 
{
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2,height-height*0.074);
  line(0,0,(height-height*0.12)*cos(radians(iAngle)),-(height-height*0.12)*sin(radians(iAngle)));//desenarea liniei corespunzatoare unghiului
  popMatrix();
}
void drawText() 
{ //scrierea textului
  pushMatrix();
  if(iDistance>40) 
  {
  noObject = "In afara";
  }
  else 
  {
  noObject = "In cerc";
  }
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.0648, width, height);
  fill(98,245,31);
  textSize(25);
  text("10cm",width-width*0.3854,height-height*0.0833);
  text("20cm",width-width*0.281,height-height*0.0833);
  text("30cm",width-width*0.177,height-height*0.0833);
  text("40cm",width-width*0.0729,height-height*0.0833);
  textSize(40);
  text("Obiectul este : " + noObject, width-width*0.875, height-height*0.0277);
  text("Unghi: " + iAngle +" °", width-width*0.48, height-height*0.0277);
  text("Distanta: ", width-width*0.26, height-height*0.0277);
  if(iDistance<40) 
  {
  text("        " + iDistance +" cm", width-width*0.175, height-height*0.0277);
  }
  textSize(25);
  fill(98,245,60);
  translate((width-width*0.4994)+width/2*cos(radians(30)),(height-height*0.0907)-width/2*sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  translate((width-width*0.503)+width/2*cos(radians(60)),(height-height*0.0888)-width/2*sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  translate((width-width*0.507)+width/2*cos(radians(90)),(height-height*0.0833)-width/2*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  translate(width-width*0.513+width/2*cos(radians(120)),(height-height*0.07129)-width/2*sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  translate((width-width*0.5104)+width/2*cos(radians(150)),(height-height*0.0574)-width/2*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
}