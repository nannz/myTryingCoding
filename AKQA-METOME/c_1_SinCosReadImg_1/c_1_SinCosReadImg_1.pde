/*read img in sin and cos order*/
import java.util.Calendar;
PImage img;

float x,y;
float amp = 2;
float angle =0;
float angleOff = 0.4;
float ampOff = 0.1;

int imgWidth = 600;
int imgHeight = 750;
color fillC;
int c = 0;
void setup(){
  size(700,850);
  background(255);
  fill(100);
  noStroke();
  
  img = loadImage("asset/Nan.jpg");
  rect(0,0,imgWidth, imgHeight);
  
  fillC = color(0,255,0);
  //image(img, 0, 0);
}

void draw(){
  img.loadPixels();
  
  //the color pixel we want to get.
  x = sin(angle) * amp;
  y = cos(angle) * amp;
  
  x = x + imgWidth/2;
  y = y + imgHeight/2;
  
  
  if(x>=0 && x <= imgWidth && y >=0 && y <= imgHeight){
    //int index = floor(x + y * imgWidth);
    //float imgBrightness = brightness(img.pixels[index]);
    //float imgSize = map(imgBrightness,0,255, 5,0.0001);
    color cc = img.get(floor(x),floor(y));
    float imgBrightness = brightness(cc);
    float imgSize = map(imgBrightness,0,255, 6,0.0001);
    fillC = color(0,255,0);
    //fill(cc);
    fill(fillC);
    ellipse(x,y, imgSize,imgSize);
    c +=1;
    println(c);//1244 ellipses in total.
  }  
  amp += ampOff;
  angle += angleOff;
  //angleOff = map(amp, 0, 10000, 0.4, 0.0001);
  
}