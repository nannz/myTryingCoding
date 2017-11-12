//try exploding in a sin/cos wave
import java.util.Calendar;

PImage[] images;
String[] imageNames;
int imageCount;
PImage imgTemp;
//ImgInfo[] imgInfoTemps = new ImgInfo[1]; //only for one image, all the particles 
ImgInfo[][] imgsInfos;
Particle[] particles = new Particle[1];

int RESOLUTION = 6;

PVector[] flowField;
float inc = 0.1;//0.1; 
int scl = 20; //scale
int cols, rows;
float zoff = 0; //the time
void setup() {
  //size(1280, 720);
  size(1680, 1050);
  background(255);
  smooth();
  noStroke();
  File dir = new File(sketchPath(""), "../b_footage_test_2");
  if (dir.isDirectory()) {
    String[] contents = dir.list();
    images = new PImage[contents.length];
    imageNames = new String[contents.length];
    for (int i = 0; i < contents.length; i++) {
      if (contents[i].charAt(0) == '.') continue;
      else if (contents[i].toLowerCase().endsWith(".jpg")) {
        File childFile = new File(dir, contents[i]);
        images[imageCount] = loadImage(childFile.getPath());
        imageNames[imageCount] = childFile.getName();
        println(imageCount + " " + contents[i] + " " + childFile.getPath());
        imageCount++;
      }
    }
  }
  //update the size of the imgs array
  imgsInfos = new ImgInfo[imageCount][1];
  /*store all the images information into the imgsInfos array one by one.*/
  for (int i = 0; i < imageCount; i ++) {
    ImgInfo[] imgInfoTemps = new ImgInfo[1]; 
    imgTemp = images[i];
    //store all the particles of this image(pos and size) to the imgInfo[]
    imgTemp.loadPixels();
    for (int y = 0; y < imgTemp.height; y += RESOLUTION) {
      for (int x = 0; x < imgTemp.width; x += RESOLUTION) {
        int imgIndex = x + y * imgTemp.width;
        float imgPBrightness = brightness(imgTemp.pixels[imgIndex]);
        float imgPSize;//= map(imgPBrightness, 0,255,6.0,0.5);
        if (imgPBrightness >= 250) {
          imgPSize = 0;
        } else {
          imgPSize = map(imgPBrightness, 0, 255, 5.0, 0.0002);
        }
        float imgPPosX =width/2 - imgTemp.width/2 + x;
        float imgPPosY = height/2 - imgTemp.height/2 + y;

        //store the pos, and size info into ImgInfo[]
        ImgInfo imgI = new ImgInfo( imgPPosX, imgPPosY, imgPSize);
        if (imgInfoTemps[0] == null) {
          imgInfoTemps[0] = imgI;
        } else {
          imgInfoTemps = (ImgInfo[])append(imgInfoTemps, imgI);
        }
      }
    }//finish analysizing this image
    //store this image info into the imgsInfos array
    imgsInfos[i] = imgInfoTemps;
  }
  //create particles for the first image
  for (int i = 0; i< imgsInfos[0].length; i++) {
    Particle p = new Particle(imgsInfos[0][i].pos.x, imgsInfos[0][i].pos.y, imgsInfos[0][i].size);
    if (particles[0] == null) {
      particles[0] = p;
    } else {
      particles = (Particle[])append(particles, p);
    }
  }

  cols = floor(width/scl);
  rows = floor(height/scl);
  //create a flowfield
  flowField = new PVector[(cols*rows)];
}

void draw() {
  //fill(255, 10);
  //rect(0, 0, width, height);
  //noFill();
  background(255,10);

  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      int index = (x + y * cols);
      /*
      //way1 to calculate the angle
       float angle = noise(xoff, yoff, zoff) * PI/2;
       angle = calAngle1(x, y, angle);
       */
      //way1 and 2 to calculate the angle
      float angle = noise(xoff, yoff, zoff) * TWO_PI;
      //angle = calAngle1(x, y, angle);

      PVector flowV = PVector.fromAngle(angle);      
      //control the speed
      flowV.setMag(0.05);
      flowField[index]=flowV;

      /*drawflowField();*/
      pushMatrix();
      //stroke(0.10);
      //translate(x*scl, y*scl);
      //rotate(flowV.heading());
      //line(0, 0, scl, 0);
      popMatrix();
      //noStroke();
      xoff += inc;
    }
    yoff += inc;
    zoff += 0.0003;
  }


  for (Particle p : particles) {

    if (p.isExploded == true){// && p.vel.mag() <= 0.001) {
      //p.vel.mult(0);
      //p.velDamping = 1;
      p.follow(flowField);
    }

    p.update();
    p.display();
  }
}

void mouseClicked() {
  for (Particle p : particles) {
    PVector force = new PVector(random(-10, 10), random(-10, 10));
    p.applyForce(force);
    p.isExploded = true;
  }
}