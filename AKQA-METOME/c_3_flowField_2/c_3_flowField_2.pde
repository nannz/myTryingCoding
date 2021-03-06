/*tried the flowfield. not effective.*/

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
BackgroundParticle[] backgroundPs = new BackgroundParticle[1];

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

//new sin/cos code for reading imgs:
float MAX_ANGLE = 1905;
float MAX_AMP = 478.11996;
float angleOff = 0.4;
float ampOff = 0.1;
float imgX, imgY;
float amp = 2;

//for flowField
float inc = 0.1;//0.1; 
int scl = 10; //scale
int cols, rows;
float zoff = 0; //the time
PVector[] flowField;
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

    //the new codes
    for (float angle = 0; angle < MAX_ANGLE; angle += angleOff) {
      imgX = sin(angle) * amp;
      imgY = cos(angle) * amp;
      imgX = imgX + imgTemp.width/2;
      imgY = imgY + imgTemp.height/2;
      if (imgX>=0 && imgX <= imgTemp.width && imgY >=0 && imgY <= imgTemp.height) {
        color cc = imgTemp.get(floor(imgX), floor(imgY));
        float imgBrightness = brightness(cc);
        float imgSize = map(imgBrightness, 0, 255, 7, 0.0001);
        //check if the particles are too dense.
        if (angle <= 200) {
          float sizeOff = map(angle, 0, 200, 0.01, 1);
          imgSize = imgSize * sizeOff;//map(amp, 0, 60,0,5);//0,51,
        } 
        float imgPPosX = imgX + imgTempXoff;
        float imgPPosY = imgY + imgTempYoff;
        //push a particle.
        ImgInfo imgI = new ImgInfo( imgPPosX, imgPPosY, imgSize);
        if (imgInfoTemps[0] == null) {
          imgInfoTemps[0] = imgI;
        } else {
          imgInfoTemps = (ImgInfo[])append(imgInfoTemps, imgI);
        }
        //c +=1;
        //println(c);//3727 ellipses in total with ampOff = 0.1; angleOff = 0.4
      }
      amp += ampOff;
    }
    amp = 2;//reset the amp.
    imgsInfos[i] = imgInfoTemps;
  }

  PVector center = new PVector(width/2, height/2);

  //create particles for the first image
  for (int i = 0; i< imgsInfos[0].length; i++) {
    Particle p = new Particle(random(10, width-10), random(10, width-10), 0);//random(0, 3));//imgsInfos[0][i].pos.x, imgsInfos[0][i].pos.y, imgsInfos[0][i].size);
    p.setImgNo(-1);
    p.isExploded = true;

    //calculate the initial acc. 

    PVector direction = PVector.sub(center, p.pos).copy();
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
  
  for(int i = 0; i < 200; i ++){
    BackgroundParticle bgP = new BackgroundParticle( random(0, width), random(0, height), 2);
    if (backgroundPs[0] == null) {
      backgroundPs[0] = bgP;
    } else {
      backgroundPs = (BackgroundParticle[])append(backgroundPs, bgP);
    }
  }

  cols = floor(width/scl);
  rows = floor(height/scl);
  //create a flowfield
  flowField = new PVector[(cols*rows)];
}

void draw() {
  //background(255);
  fill(255, 40);
  rect(0, 0, width, height);
  noFill();

//generate flow field
  //float yoff = 0;
  //for (int y = 0; y < rows; y++) {
  //  float xoff = 0;
  //  for (int x = 0; x < cols; x++) {
  //    int index = (x + y * cols);
  //    float angle = noise(xoff, yoff, zoff) * TWO_PI;
  //    //if (x > floor(cols/2)) angle = PI - angle;
  //    PVector flowV = PVector.fromAngle(angle);      
  //    //control the speed
  //    flowV.setMag(0.05);
  //    flowField[index]=flowV;    
  //    /*drawflowField();*/
      
  //    xoff += inc;
  //  }
  //  yoff += inc;
  //  zoff += 0.0003;
  //}
//finish updating the flowfield.


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
      if (millis() - clickedMoment2 >= 1000*2.5) {
        allExploded = false;
        allNext = true;
        for (int i = 0; i < particles.length; i ++) {
          Particle p = particles[i];
          p.isExploded = false;
          p.isNext = true;
        }
        if (particleImgCount == imgsInfos.length) {
          particleImgCount = 0;
        }
        setAllParticleImgCount(particleImgCount);
        println("particleImgCount: "+particleImgCount);
        clickedMoment = millis();
      }
    }
    if (allNext) {
      for (int i = 0; i < particles.length; i ++) {
        Particle p = particles[i];
        //particles[i].follow(flowField);
        if (p.isNext == true) {
          /*check if it goes to the end*/
          if ((p.imageNo+1) == imgsInfos.length) {
            p.imageNo = -1;
          }//else if(p.imageNo == -1);
          ImgInfo nextImg = imgsInfos[p.imageNo+1][i];
          PVector distance = PVector.sub(nextImg.pos, p.pos);
          PVector destDirection = PVector.sub(distance, p.vel);
          destDirection.normalize();
          destDirection = destDirection.mult(distance.mag() * 0.007);
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
            //particles[i].follow(flowField);
          }
          //particles[i].follow(flowField);
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
          //PVector individualForce = new PVector(random(-1, 1), random(-1, 1));
          //particles[i].applyForce(individualForce);
          particles[i].applyForce(force);
          //particles[i].follow(flowField);
        }
      }
    }
  }
  for (int i = 0; i < particles.length; i ++) {
    Particle p = particles[i];
    p.update();
    p.display();
  }

  //for (int i = 0; i < backgroundPs.length; i++) {
  //  BackgroundParticle bgP = backgroundPs[i];
  //  bgP.follow(flowField);
  //  bgP.update();
  //  bgP.edges();
  //  bgP.display();
  //}
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
  //particleImgCount = 0;
  //particleImgCount +=1;
}



float t;
PVector drawAgent() {
  pushMatrix();
  translate(width/2, height/2);
  float xVal = sin(frameCount/10)*100 + sin(frameCount/5)*20;
  float yVal = cos(-frameCount/10)* 100 + sin(frameCount/5) *50;
  popMatrix();

  t+= 0.2;

  PVector agentPos = new PVector(1.2*(xVal+width/2), 1.2*(yVal+height/2));
  return agentPos;
}

void setAllParticleImgCount(int c) {
  for (int i = 0; i < particles.length; i ++) {
    Particle p = particles[i];
    p.setImgNo(c);
  }
}