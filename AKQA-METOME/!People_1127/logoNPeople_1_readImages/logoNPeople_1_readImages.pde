/*add state 2: logo -> dots of particles*/
/*state 0: if edge, splice and create a new one*/
/*state1: if edged, not create new one*/
/*when length is 0, fade out the background*/

int state = 1;

float inc = 0.1;//0.1; 
int scl = 20; //scale
int cols, rows;

float zoff = 0; //the time
int noOfPoints = 2000;
Particle[] particles;// = new Particle[noOfPoints];
PVector[] flowField;
PShape logo;
int children;
PVector[] particlePoses;
int pCount = 0;
PVector wind;
PVector windCenter;

import controlP5.*;
ControlFrame cf;
float rad = 1.5;
boolean showLogo = true;
boolean recording = false;
float windCenterX = 840.0;
float windCenterY = 525.0;
boolean showWindCenter = false;
float windMag = 0.03;
boolean applyWind = true;
boolean applyFlowField = false;
float flowMag = 0.05;
float flowAngle = TWO_PI;
float maxVel = 1.5;

PImage logoImg;
PImage logoParticleImg;//for state 2
ImgInfo[] logoImgInfo;


//new sin/cos code for reading imgs:
float MAX_ANGLE = 1905;
float MAX_AMP = 478.11996;
float angleOff = 0.4;
float ampOff = 0.08;//0.1;
float imgX, imgY;
float amp = 2;

//logo particles
PeopleParticle[] logoParticles = new PeopleParticle[1];
boolean createLogoParticle = true;

//people imgs & particles
PImage[] images;
String[] imageNames;
int imageCount;
PImage imgTemp;
ImgInfo[][] imgsInfos;
float imgPSize_MAX = 3.0;
PeopleParticle[] peopleParticles = new PeopleParticle[1];
int clickedMoment;
int clickedMoment2;
boolean allNexted = false;
boolean allExploded = true;
boolean allNext = false;
int particleImgCount = 0;
float time4Flying = 2.2;
float time4FormingNext = 4.5;
PVector agent;

boolean state3Start = true;


int state1to3Moment;
float time4State1 = 1.0;
boolean triggerTimeForState1to3 = false;
boolean triggerRecord = false;
void settings() {
  size(1680, 1050, P2D);
}
void setup() {
  //set up the control P5 panel
  cf = new ControlFrame(this, 400, 800, "Controls");
  surface.setLocation(0, 0);//420, 10);  

  background(255);
  hint(DISABLE_DEPTH_MASK);
  //loadShape of the logo
  logo = loadShape("logo/akqash2.svg");
  println(logo.width + " " + logo.height);
  logoImg = loadImage("logo/logoImg.png", "png");
  logoParticleImg = loadImage("logo/people-logo.jpg");

  /*the flowField and logo vertex.*/
  pixelDensity(displayDensity());
  smooth();
  children = logo.getChildCount();
  println("children number: " + children);
  cols = floor(width/scl);
  rows = floor(height/scl);
  //create a flowfield
  flowField = new PVector[(cols*rows)];
  for (int i = 0; i < children; i++) {
    PShape child = logo.getChild(i);
    int noOfVertex = child.getVertexCount();
    pCount += noOfVertex;
  }
  println("pCount: " + pCount);
  noOfPoints = pCount;
  particlePoses = new PVector[noOfPoints];
  particles = new Particle[noOfPoints];
  //iterate the child shapes of the logo
  createParticlePoses();
  for (int i = 0; i < noOfPoints; i++) {
    particles[i] = new Particle();
    particles[i].pos = particlePoses[i].copy();
  }
  noStroke();
  windCenter = new PVector(width/2 + 30, height/2 + 57);



  //--------------------logo for loop People part and the people image read and save into imgInfo -----------------//
  /*save the logo particle info into ImgInfo object*/
  logoImgInfo = saveLogo2ImgInfo();
  println(logoImgInfo.length - 1 + " "+logoImgInfo[logoImgInfo.length - 1].size);

  /*read images and save them into ImgInfo[][]*/
  File dir = new File(sketchPath(""), "/data/people");
  if (dir.isDirectory()) {
    String[] contents = dir.list();
    contents = sort(contents);
    //println(contents);
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
      }
      amp += ampOff;
    }
    //println(i + " " + imgInfoTemps.length);
    amp = 2;//reset the amp.
    imgsInfos[i] = imgInfoTemps;
  }
  println("finish reading");
}



int bgTrans = 10;
void draw() {
  if (particles.length>0) {
    fill(255, 10);
    rect(0, 0, width, height);
  } else {  
    if (state == 3) {
      fill(255, 40);
      rect(0, 0, width, height);
    } else {
      fill(255, bgTrans);
      rect(0, 0, width, height);
      bgTrans +=1;
      if (bgTrans >= 255) {
        bgTrans = 255;
      }
    }
  }

  noFill();
  if (state < 2) {
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        int index = (x + y * cols);
        //way1 and 2 to calculate the angle
        float angle = noise(xoff, yoff, zoff) * flowAngle;
        angle = calAngle1(x, y, angle);

        PVector flowV = PVector.fromAngle(angle);      
        //control the speed
        flowV.setMag(flowMag);
        flowField[index]=flowV;
        xoff += inc;
      }
      yoff += inc;
      zoff += 0.0003;
    }
    fill(0);
    //update the windCenter
    windCenter.x = windCenterX;
    windCenter.y = windCenterY;
    for (int i = 0; i < particles.length; i++) {
      particles[i].setMaxVel(maxVel);
      if (applyWind) {
        if (particles[i].pos.y < windCenter.y) {
          wind = new PVector(0, -1);
        } else {
          wind = new PVector(0, 1);
        }
        wind.mult(windMag);
        particles[i].applyForce(wind);
      }
      particles[i].setRad(rad);
      if (applyFlowField) {
        particles[i].follow(flowField);
      }
      particles[i].update();
      if (particles.length > 0) {
        particles[i].display();
      }
      particles[i].edges();

      if (particles[i].isEdged == true) {
        if (state == 0) {
          particles[i].pos = particlePoses[i].copy(); //鼠标不能多点，没有同步。
          particles[i].vel = new PVector(0, 0);
          particles[i].isEdged = false;
        } else if (state == 1) {
          //delete this particle from the array.
          //subset into 2 arrays, the first use shorten(), combine the two arrays.
          if (i < particles.length-1) {
            Particle[] pTempsA = (Particle[])subset(particles, 0, i+1);
            Particle[] pTempsB = (Particle[])subset(particles, i+1);
            pTempsA = (Particle[])shorten(pTempsA);
            particles = (Particle[])splice(pTempsA, pTempsB, i);
          } else if(i == particles.length-1){//only one
            particles =  (Particle[])shorten(particles);
          }else{
            particles = null;
          }
        }
      }
    }  
    //println(particles.length);//最小是0
    if (particles.length == 0) {
      triggerTimeForState1to3 = true;
      //print("allDead");
    }   
    if (triggerTimeForState1to3 == true && triggerRecord == false) {
      state1to3Moment = millis();
      triggerTimeForState1to3 = false;
      triggerRecord = true;
    } 
    //println(millis() - state1to3Moment);
    if (triggerRecord == true && (millis() - state1to3Moment) >= 1000 * time4State1) {
      state1to3Moment = millis();
      state = 3;  
      //triggerTimeForState1to3 = false;
    }
  }
  //println(state);
  //-------------finish state 0 and 1-----------------//

  /*state2: read logo once, display the logoParticles[]*/
  if (state == 2) {
    //createParticles of logo
    if (createLogoParticle) {
      for (int i = 0; i < logoImgInfo.length; i++) {
        PeopleParticle logoP = new PeopleParticle(logoImgInfo[i].pos.x, logoImgInfo[i].pos.y, logoImgInfo[i].size);
        logoP.setImgNo(-1);
        logoP.isExploded = false;
        if (logoParticles[0] == null) {
          logoParticles[0] =logoP;
        } else {
          logoParticles = (PeopleParticle[])append(logoParticles, logoP);//!!!!!!!!!!!
        }
      }
      createLogoParticle = false;
    }
    for (int i = 0; i < logoParticles.length; i ++) {
      logoParticles[i].display();
    }
  }
  /*state3: logo explode and goto next img*/
  if (state == 3) {
    agent = drawAgent();
    if (state3Start) {
      //createParticle based on logoParticles once.
      //give initial acc, explode statement is different
      PVector center = new PVector(width/2, height/2);
      println("length1 " + imgsInfos[0].length);
      println("length2 " +logoImgInfo.length);
      for (int i = 0; i < logoImgInfo.length; i++) {
        PeopleParticle pp = new PeopleParticle(logoImgInfo[i].pos.x, logoImgInfo[i].pos.y, logoImgInfo[i].size);
        pp.setImgNo(0);
        pp.isExploded = true;
        pp.isNext = false;
        //calculate the initial acc. 
        PVector direction = PVector.sub(center, pp.pos).copy();
        direction.normalize();
        direction.mult(1.3);
        float rotateTheta = direction.heading()+PI/4;
        direction.rotate(rotateTheta);
        pp.acc = direction.copy();
        if (peopleParticles[0] == null) {
          peopleParticles[0] = pp;
        } else {
          peopleParticles = (PeopleParticle[])append(peopleParticles, pp);
        }
      }
      state3Start = false;
    } 
    if (mode == 0) {
      for (int i = 0; i < peopleParticles.length; i ++) {
        PeopleParticle pp = peopleParticles[i];
        pp.applyAttraction(agent);
      }
    } else {//mode = 1
      if (allExploded) {
        for (int i = 0; i < peopleParticles.length; i ++) {
          PeopleParticle pp = peopleParticles[i];
          pp.applyAttraction(agent);
        }
        if (millis() - clickedMoment2 >= 1000* time4Flying) {
          allExploded = false;
          allNext = true;
          for (int i = 0; i < peopleParticles.length; i ++) {
            PeopleParticle pp = peopleParticles[i];
            pp.isExploded = false;
            pp.isNext = true;
          }
          if (particleImgCount == imgsInfos.length) {
            particleImgCount = 0;
          }
          setAllParticleImgCount(particleImgCount);
          clickedMoment = millis();
        }
      }
      if (allNext) {
        for (int i = 0; i < peopleParticles.length; i ++) {
          PeopleParticle pp = peopleParticles[i];
          if (pp.isNext == true) {
            /*check if it goes to the end*/
            if ((pp.imageNo+1) == imgsInfos.length) {
              pp.imageNo = 0;
            }//else if(p.imageNo == -1);
            ImgInfo nextImg = imgsInfos[pp.imageNo+1][i];
            PVector distance = PVector.sub(nextImg.pos, pp.pos);
            PVector destDirection = PVector.sub(distance, pp.vel);
            destDirection.normalize();
            destDirection = destDirection.mult(distance.mag() * 0.007);
            pp.applyForce(destDirection);
            /*changing the size*/
            pp.size = nextImg.size;
            //check if arrive the destination points
            if  (pp.pos.dist(nextImg.pos)<1) {
              //println("particle "+i + ": next arrived!");
              peopleParticles[i] = null;
              int pImageNo = pp.imageNo+1;
              peopleParticles[i] = new PeopleParticle(imgsInfos[pImageNo][i].pos.x, imgsInfos[pImageNo][i].pos.y, imgsInfos[pImageNo][i].size);
              peopleParticles[i].imageNo = pImageNo;
            }
          }
        }
        if (millis() - clickedMoment >= 1000* time4FormingNext) {//explode!
          particleImgCount +=1;
          println("time's up!");
          clickedMoment2 = millis();
          allNext = false;
          allExploded = true;
          PVector force = new PVector(random(-10, 10), random(-10, 10));//总的force
          for (int i = 0; i < peopleParticles.length; i ++ ) {
            peopleParticles[i].isNext = false;
            peopleParticles[i].isExploded = true;
            PVector individualForce = new PVector(random(-10, 10), random(-10, 10));
            PVector combinedForce = force.copy().mult(1).add(individualForce.copy().mult(0));
            peopleParticles[i].applyForce(combinedForce);
            //peopleParticles[i].applyForce(individualForce);
            //peopleParticles[i].applyForce(force);
          }
        }
      }
    }
    for (int i = 0; i < peopleParticles.length; i++) {
      PeopleParticle pp = peopleParticles[i];
      pp.update();
      pp.display();
    }
  }



  /*logo*/
  if (showLogo&& (state < 2)) {
    //showLogo();//800, 468
    image(logoImg, width/2 - 800/2, height/2 - 468/2, 800, 468);
  }
  noStroke();
  if (recording) {
    saveFrame("output/frame_####.tif");
  }
}
boolean programStarted = false;
int mode = 0;
void mouseClicked() {
  if (state == 3) {
    if (programStarted == false) {
      clickedMoment = millis();
      mode = 1;
      wind = new PVector(random(-20, 20), random(-20, 20));
      allNext = true;
      allExploded = false;
      for (int i = 0; i < peopleParticles.length; i ++) {
        PeopleParticle pp = peopleParticles[i];
        pp.isNext = true;
        pp.isExploded = false;
        pp.applyForce(wind);
      }
      programStarted = true;
    }
  }
  //particleImgCount = 0;
  //particleImgCount +=1;
}


float calAngle1(int x, int y, float angle) {
  if (x > floor(cols/2)) {
    angle = PI - angle;
  }
  return angle;
}



void showLogo() {
  image(logoImg, width/2 - logo.width/2, height/2- logo.height/2, logo.width, logo.height);
}