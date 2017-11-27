/*draw the road of sin and cos*/
//should draw in 椭圆
float x,y;
float amp = 2;
float angle =0;
float angleOff = 0.4;
float ampOff = 0.3;
void setup(){
  size(600,750);
  background(255);
  fill(100);
  noStroke();
}

void draw(){
  //background(255);
  //sin(freq)* amp
  
  translate(width/2, height/2);
  //the color pixel we want to get.
  x = sin(angle) * amp;
  y = cos(angle) * amp;
  //line(0,0, x, y);
  //can add check function to determine if not to draw the dot(add the particle)
  ellipse(x,y, 2,2);
  
  amp += ampOff;
  angle += angleOff;
  //angleOff = map(amp, 0, 10000, 0.4, 0.0001);
}