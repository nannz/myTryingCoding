/*draw the road of sin and cos*/
//should draw in 椭圆
float x,y;
float amp = 2;
float angle =0;
float angleOff = 0.4;
float ampOff = 0.3;

int imgWidth = 600;
int imgHeight = 750;
color fillC;
int c = 0;
void setup(){
  size(700,850);
  background(255);
  fill(100);
  noStroke();
  rect(0,0,imgWidth, imgHeight);
  
  fillC = color(0,255,0);
}

void draw(){
  fill(fillC);
  //background(255);
  //sin(freq)* amp
  
  //translate(width/2, height/2);
  //the color pixel we want to get.
  x = sin(angle) * amp;
  y = cos(angle) * amp;
  
  x = x + imgWidth/2;
  y = y + imgHeight/2;
  
  if(x>=0 && x <= imgWidth && y >=0 && y <= imgHeight){
    fillC = color(0,255,0);
    fill(fillC);
    ellipse(x,y, 2,2);
    c +=1;
    println(c);//1244 ellipses in total.
  }  
  amp += ampOff;
  angle += angleOff;
  //angleOff = map(amp, 0, 10000, 0.4, 0.0001);
  
}