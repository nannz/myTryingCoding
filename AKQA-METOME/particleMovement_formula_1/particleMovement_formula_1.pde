//try bubboy's formula into the agent movement formula
/*
var mult = 0.25;
for (i = 0; i < numblobs; i++) {
  bally = 1;
  ballx = Math.sin(i + 1.26 * time * (1.03 + 0.5 * Math.cos(0.21 * i))) * 0.5 + mult;
  ballz = Math.cos(i + 1.32 * time * 0.1 * Math.sin((0.92 + 0.53 * i))) * 0.5 + mult;
  object.addBall(ballx, bally, ballz, strength, subtract);
}
*/ 

float posX;
float posY;
int i = 0;
float sinVal, cosVal;
float amp = 50;
void setup(){
  size(500,500);
  background(255);
  noStroke();

}

void draw(){
  //background(255,10);
  //sin(freq)*amp
  sinVal = sin(i + 1.26 * millis() * (1.03 + 0.5 * cos(0.21 * i)));
  cosVal = cos(i + 1.32 * millis() * (0.1 * sin(0.92 + 0.53 * i)));
  
  translate(width/2,height/2);
  //rotate(frameCount * 0.01);
  fill(255, 0,0);
  ellipse(sinVal*amp, cosVal * amp, 2,2);
  //line(0, 0, sinVal * amp, 0);
}