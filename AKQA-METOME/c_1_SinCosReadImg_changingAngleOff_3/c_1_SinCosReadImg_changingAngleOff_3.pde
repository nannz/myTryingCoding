/*read img in sin and cos order*/
import java.util.Calendar;
PImage img;

float x, y;
float amp = 2;
float angle =0;
float angleOff = 0.4;
float ampOff = 0.1;

int imgWidth = 600;
int imgHeight = 750;
color fillC;
int c = 0;
//3727 ellipses(c) in total with ampOff = 0.1; angleOff = 0.4
//c = 3727, angle = 1904.4794; amp = 478.11996

void setup() {
  size(700, 850);
  background(255);
  fill(100);
  noStroke();

  img = loadImage("../b_footage_all/Yvonne.jpg");
  //rect(0,0,imgWidth, imgHeight);

  fillC = color(0);
  //image(img, 0, 0);
  img.loadPixels();
  float min_off = 1;
  float max_off = 0;
  for (float amp = 2; amp < 478.2; amp += ampOff) {
    //if (c <=3727) {
    //the color pixel we want to get.
    x = sin(angle) * amp;
    y = cos(angle) * amp;
    x = x + imgWidth/2;
    y = y + imgHeight/2;
    if (x>=0 && x <= imgWidth && y >=0 && y <= imgHeight) {
      color cc = img.get(floor(x), floor(y));
      float imgBrightness = brightness(cc);
      float imgSize = map(imgBrightness, 0, 255, 7, 0.0001);
      float newSizeOff = imgSize * amp;
      if (newSizeOff < min_off) {
        min_off = newSizeOff;
      }
      if (newSizeOff > max_off) {
        max_off = newSizeOff;
      }
      fill(0); 
      if (angle <= 200 ){//&& imgSize >= 6) {
        println(amp + " " + imgSize);//amp = 39.49
        float sizeOff = map(angle, 0, 200, 0.01, 1);
        imgSize = imgSize * sizeOff;//map(amp, 0, 60,0,5);//0,51,
      } 
      //imgSize = lerp(0.001, 0.09, lerpVal);
      ellipse(x, y, imgSize, imgSize);
      c +=1;
      //println(c);//3727 ellipses in total with ampOff = 0.1; angleOff = 0.4
    }
    angle += angleOff;
  }
  println("min_off: "+min_off);//for melody.jpg, 0.015
  println("min_off: "+max_off);//for melody.jpg, 2517.107
}


void draw() {
}