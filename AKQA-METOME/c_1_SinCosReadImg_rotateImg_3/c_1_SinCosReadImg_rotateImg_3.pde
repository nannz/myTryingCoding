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
float angle2 = 0.1;
//3727 ellipses(c) in total with ampOff = 0.1; angleOff = 0.4
//c = 3727, angle = 1904.4794; amp = 478.11996

void setup() {
  size(700, 850);
  background(255);
  fill(100);
  noStroke();

  img = loadImage("../b_footage_all/Edward.jpg");
  //rect(0,0,imgWidth, imgHeight);

  fillC = color(0);
  //image(img, 0, 0);
  img.loadPixels();
  for (float angle = 0; angle < 1905; angle += angleOff) {

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
      fill(0); 
      if (angle <= 150 && imgSize >= 3) {
        println(amp);//amp = 39.49
        imgSize = map(amp, 0, 40,0,5);
      }
      pushMatrix();
      rotate(angle2);
      ellipse(x, y, imgSize, imgSize);
      popMatrix();
      c +=1;
      //println(c);//3727 ellipses in total with ampOff = 0.1; angleOff = 0.4
    }
    
    amp += ampOff;
    //}
  }
}


void draw() {
}