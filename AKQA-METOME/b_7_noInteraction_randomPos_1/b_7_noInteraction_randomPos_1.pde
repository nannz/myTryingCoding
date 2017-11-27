/*add logo*/

import java.util.Calendar;
PShape logo;
PImage[] images;
String[] imageNames;
int imageCount;
PImage imgTemp;
//ImgInfo[] imgInfoTemps = new ImgInfo[1]; //only for one image, all the particles 
ImgInfo[][] imgsInfos;
float imgPSize_MAX = 4.0;
Particle[] particles = new Particle[1];

int RESOLUTION = 6;

float initialDistance = 0;

PVector wind;
PVector agent;

int mode = 0;

int clickedMoment;
int clickedMoment2;
boolean allNexted = false;
boolean allExploded = true;
boolean allNext = false;
boolean programStarted = false;

int particleImgCount = 0;
void setup() {
  //size(1280, 720);
  size(1680, 1050);
  background(255);
  smooth();
  noStroke();
  //logo = loadShape("../footage_logo/akqash.svg");
  //logo.scale(0.2);
  File dir = new File(sketchPath(""), "../b_footage_all");
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
    float imgTempXoff = random(50, width - 50 - imgTemp.width);
    float imgTempYoff = random(50, height - 50 - imgTemp.height);
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
        /*
        float imgPPosX =width/2 - imgTemp.width/2 + x;
        float imgPPosY = height/2 - imgTemp.height/2 + y;
        */
        float imgPPosX = x+ imgTempXoff;
        float imgPPosY = y + imgTempYoff;

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
  PVector center = new PVector(width/2, height/2);
  
  //create particles for the first image
  for (int i = 0; i< imgsInfos[0].length; i++) {
    Particle p = new Particle(random(10, width-10), random(10, width-10), random(0, 3));//imgsInfos[0][i].pos.x, imgsInfos[0][i].pos.y, imgsInfos[0][i].size);
    p.setImgNo(-1);
    p.isExploded = true;
    
    //calculate the initial acc. 

    PVector direction = PVector.sub(center,p.pos).copy();
    direction.normalize();
    direction.mult(1.3);
    float rotateTheta = direction.heading()+PI/4;
    direction.rotate(rotateTheta);
    p.acc = direction.copy();//new PVector(random(-20, 20), random(-20, 20));
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
  if (mode == 0) {
    for (int i = 0; i < particles.length; i ++) {
      Particle p = particles[i];
      p.applyAttraction(agent);
      p.update();
      p.display();
    }
  } else {//mode = 1
    if (allExploded) {
      for (int i = 0; i < particles.length; i ++) {
        Particle p = particles[i];
        p.applyAttraction(agent);
      }

      if (millis() - clickedMoment2 >= 1000*7) {
        allExploded = false;
        allNext = true;
        for (int i = 0; i < particles.length; i ++) {
          Particle p = particles[i];
          p.isExploded = false;
          p.isNext = true;         
        }
        setAllParticleImgCount(particleImgCount);
        println("particleImgCount: "+particleImgCount);
        clickedMoment = millis();
      }
    }
    if (allNext) {
      for (int i = 0; i < particles.length; i ++) {
        Particle p = particles[i];
        if (p.isNext == true) {
          /*check if it goes to the end*/
          if ((p.imageNo+1) == imgsInfos.length) {
            p.imageNo = -1;
          }//else if(p.imageNo == -1);
          ImgInfo nextImg = imgsInfos[p.imageNo+1][i];
          PVector distance = PVector.sub(nextImg.pos, p.pos);
          PVector destDirection = PVector.sub(distance, p.vel);
          destDirection.normalize();
          destDirection = destDirection.mult(distance.mag() * 0.015);
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
      }

      if (millis() - clickedMoment >= 1000*4) {//explode!
        particleImgCount +=1;
        println("time's up!");
        clickedMoment2 = millis();
        allNext = false;
        allExploded = true;
        
        PVector force = new PVector(random(-10, 10), random(-10, 10));
        for (int i = 0; i < particles.length; i ++ ) {
          particles[i].isNext = false;
          particles[i].isExploded = true;
          particles[i].applyForce(force);
        }
      }
    }
  }
  for (int i = 0; i < particles.length; i ++) {
    Particle p = particles[i];
    p.update();
    p.display();
  }
  
  //display the logo
  //shape(logo, 10, -20);//width/2 - logo.width/2, height/2- logo.height/2);
}


void mouseClicked() {
  if (programStarted == false) {
    clickedMoment = millis();
    mode = 1;
    wind = new PVector(random(-20, 20), random(-20, 20));
    allNext = true;
    allExploded = false;
    
    for (int i = 0; i < particles.length; i ++) {
      Particle p = particles[i];
      p.isNext = true;
      p.isExploded = false;
      p.applyForce(wind);
    }
    programStarted = true;
  }
  
  //particleImgCount +=1;
}



float t;
PVector drawAgent() {
  pushMatrix();
  translate(width/2, height/2);
  //float yVal = sin(frameCount * 0.1)*(frameCount*0.1 + width/2);
  //float xVal = cos(frameCount * 0.1)*(frameCount*0.1 + height/2);
  //float xVal = sin(t/10)*100 + sin(t/5)*20;
  //float yVal = cos(-t/10)* 100 + sin(t/5) *50;
  float xVal = sin(frameCount/10)*100 + sin(frameCount/5)*20;
  float yVal = cos(-frameCount/10)* 100 + sin(frameCount/5) *50;
  //fill(255, 0, 0);
  //stroke(1);
  //line(0,0,xVal*10,yVal*10);
  //noStroke();
  //ellipse(xVal*10,yVal*10, 10, 10);
  popMatrix();

  t+= 0.2;

  PVector agentPos = new PVector(1.2*(xVal+width/2), 1.2*(yVal+height/2));
  return agentPos;
}

void setAllParticleImgCount(int c){
  for (int i = 0; i < particles.length; i ++) {
      Particle p = particles[i];
      p.setImgNo(c);
  }
}
/*
float thisTime = millis();
 println(thisTime-clickedMoment);
 if (millis()-clickedMoment >= 1000*10) {
 println("yo!");
 //if > 10s; explode!
 p.isNext = false;
 p.isExploded = true;
 PVector force = new PVector(random(-10, 10), random(-10, 10));
 p.applyForce(force);
 }*/