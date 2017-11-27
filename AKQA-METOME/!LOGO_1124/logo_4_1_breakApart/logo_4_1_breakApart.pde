/*get another layer of wind force.*/
/*state 0: if edge, splice and create a new one*/
/*state1: if edged, not create new one*/
/*when length is 0, fade out the background*/
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
int state = 1;

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
  logo = loadShape("akqash2.svg");
  println(logo.width + " " + logo.height);
  logoImg = loadImage("logoImg.png", "png");

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

  //windCenter = new PVector(width/2 + 30, height/2 + 57);
  windCenter = new PVector(width/2, height/2);
}
int bgTrans = 10;
void draw() {
  if (particles.length>0) {
    fill(255, 10);
    rect(0, 0, width, height);
  } else {  
    fill(255, bgTrans);
    rect(0, 0, width, height);
    bgTrans +=1;
    if(bgTrans >= 255){
      bgTrans = 255;
    }
  }
  noFill();

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
      //PVector direction = PVector.sub(particles[i].pos, windCenter);
      //direction.normalize();
      //wind = PVector.sub(direction, particles[i].vel);
      //wind.mult(windMag);
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
        } else {
          particles =  (Particle[])shorten(particles);
        }
      }
    }
  }
  //println(particles.length);

  if (showLogo) {
    //showLogo();//800, 468
    image(logoImg, width/2 - 800/2, height/2 - 468/2, 800, 468);
  }
  noStroke();

  if (showWindCenter) {
    fill(255, 0, 0);
    ellipse(windCenter.x, windCenter.y, 3, 3);
  }
  if (recording) {
    saveFrame("output/frame_####.tif");
  }
}


float calAngle1(int x, int y, float angle) {

  if (x > floor(cols/2)) {
    angle = PI - angle;
  }
  /*
  if (x<= floor(cols/2) && y <= floor(rows/2)) {//左上
   angle = angle + PI;
   } else if ( x > floor(cols/2) && y <= floor(rows/2)) {//右上
   angle = TWO_PI - angle;
   } else if (x<= floor(cols/2) && y > floor(rows/2)) {//左下
   angle = PI - angle;
   } else if (x > floor(cols/2) && y > floor(rows/2)) {//右下
   angle = angle;
   } 
   */
  return angle;
}



float calAngle2(int x, int y, float angle) {
  if (x<= floor(cols/2) && y <= floor(rows/2)) {//左上
    angle = map(angle, 0, TWO_PI, PI, PI * 3 / 2);
  } else if ( x > floor(cols/2) && y <= floor(rows/2)) {//右上
    angle = map(angle, 0, TWO_PI, PI * 3 / 2, TWO_PI);
  } else if (x<= floor(cols/2) && y > floor(rows/2)) {//左下
    angle = map(angle, 0, TWO_PI, PI/2, PI);
  } else if (x > floor(cols/2) && y > floor(rows/2)) {//右下
    angle = map(angle, 0, TWO_PI, 0, PI/2);
  }
  return angle;
}

void showLogo() {
  //svg file show
  //logo.disableStyle();
  ////stroke(0);
  ////strokeWeight(1);
  //fill(0);
  //shape(logo, width/2 - logo.width/2, height/2- logo.height/2);

  //png file show
  image(logoImg, width/2 - logo.width/2, height/2- logo.height/2, logo.width, logo.height);
}