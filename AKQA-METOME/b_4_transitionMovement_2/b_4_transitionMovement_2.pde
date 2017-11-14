

import java.util.Calendar;

PImage[] images;
String[] imageNames;
int imageCount;
PImage imgTemp;
//ImgInfo[] imgInfoTemps = new ImgInfo[1]; //only for one image, all the particles 
ImgInfo[][] imgsInfos;
float imgPSize_MAX = 4.0;
Particle[] particles = new Particle[1];

int RESOLUTION = 6;

boolean allNext = true;
float initialDistance = 0;

PVector wind;
PVector agent;
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
          imgPSize = map(imgPBrightness, 0, 255, imgPSize_MAX, 0.0002);
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
    p.setImgNo(0);
    if (particles[0] == null) {
      particles[0] = p;
    } else {
      particles = (Particle[])append(particles, p);
    }
  }
}

void draw() {
  //background(255);
  fill(255, 40);
  rect(0, 0, width, height);
  noFill();
  
  agent = drawAgent();




  for (int i = 0; i < particles.length; i ++) {
    Particle p = particles[i];
    if (p.isExploded == true) {
      p.applyAttraction(agent);
    }
    //if isNext = true
    //applyAttraction to the destination position
    //next image = imgsInfos[p.imageNo +1]
    if (
      //p.isExploded == true && 
      p.isNext == true) {
      ImgInfo nextImg = imgsInfos[p.imageNo+1][i];

      /*apply the force towards the destination*/
      PVector distance = PVector.sub(nextImg.pos, p.pos);
      PVector destDirection = PVector.sub(distance, p.vel);
      //PVector destDirection = PVector.sub(nextImg.pos, p.pos);
      destDirection.normalize();
      destDirection = destDirection.mult(distance.mag() * 0.02);
      p.applyForce(destDirection);

      /*changing the size*/
      p.size = nextImg.size;

      //check if arrive the destination points
      if  (p.pos.dist(nextImg.pos)<1) {
        //println("particle "+i + ": next arrived!");
        particles[i] = null;
        int pImageNo = p.imageNo+1;
        particles[i] = new Particle(imgsInfos[pImageNo][i].pos.x, imgsInfos[pImageNo][i].pos.y, imgsInfos[pImageNo][i].size);
        particles[i].imageNo = pImageNo;
      }
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
  println("applied!");
}

void keyPressed() {
  wind = new PVector(random(-20, 20), random(-20, 20));
  for (int i = 0; i < particles.length; i ++) {
    Particle p = particles[i];
    if (keyPressed && key == CODED) {
      if (keyCode == RIGHT) {
        p.isNext = true;
        p.isExploded = false;
        ImgInfo nextImg = imgsInfos[p.imageNo+1][i];
        //record the initial distance to the target point 
        p.initialDistance = PVector.dist(p.pos, nextImg.pos);

        /*apply wind*/
        p.applyForce(wind);

        //p.isExploded = false;
      }
    }
  }
}
float t;
PVector drawAgent() {
  pushMatrix();
  translate(width/2, height/2);
  //float yVal = sin(frameCount * 0.1)*(frameCount*0.1 + width/2);
  //float xVal = cos(frameCount * 0.1)*(frameCount*0.1 + height/2);
  float xVal = sin(t/10)*100 + sin(t/5)*20;
  float yVal = cos(-t/10)* 100 + sin(t/5) *50;
  fill(255, 0, 0);
  stroke(1);
  //line(0,0,xVal*10,yVal*10);
  noStroke();
  //ellipse(xVal*10,yVal*10, 10, 10);
  popMatrix();

  t+= 0.2;

  PVector agentPos = new PVector(1.2*(xVal+width/2), 1.2*(yVal+height/2));
  return agentPos;
}