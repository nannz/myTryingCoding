/*change noise range.*/
/*if edge, splice and create a new one*/


float inc = 0.1;//0.1; 
int scl = 10; //scale
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
int indexCount;//for counting the particles' index in setup

void setup() {
  size(1280, 720, P2D);
  background(255);
  smooth();
  hint(DISABLE_DEPTH_MASK);
  //loadShape of the logo
  //logo = loadShape("logo.svg");
  logo = loadShape("../footage_logo/akqash2.svg");
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
  println("child1: "+logo.getChild(0).getVertexCount());
  println("child2: "+logo.getChild(1).getVertexCount());
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
}

void draw() {
  fill(255, 10);
  rect(0, 0, width, height);
  noFill();
  //background(255,255,255,5);
  
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
      angle = calAngle1(x, y, angle);
      //way3: simply change the range of the noise;
      //float angle = noise(xoff, yoff, zoff) * PI*3;
      
      PVector flowV = PVector.fromAngle(angle);      
      //control the speed
      flowV.setMag(0.03);
      flowField[index]=flowV;
      
      /*drawflowField();*/
      pushMatrix();
      stroke(0.10);
      translate(x*scl, y*scl);
      //rotate(flowV.heading());
      //line(0, 0, scl, 0);
      //fill(255,0,0);
      //ellipse(0,0,3,3);
      popMatrix();
      //noStroke();
      xoff += inc;
    }
    yoff += inc;
    zoff += 0.0003;
  }
  fill(0);
  
  for (int i = 0; i < particles.length; i++) {
    /*disable the wind for this version(4)
    if(particles[i].pos.y < height/2){
      wind = new PVector(0,-0.03);
    }else{
      wind = new PVector(0,0.03);
    }
    particles[i].applyForce(wind);
    */
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].edges();
    
    if(particles[i].isEdged == true){
      particles[i].pos = particlePoses[i].copy(); //鼠标不能多点，没有同步。
      particles[i].vel = new PVector(0,0);
      particles[i].isEdged = false;
    }
    particles[i].display();
  }
  
  logo.disableStyle();
  stroke(0);
  strokeWeight(0.75);
  fill(255);
  shape(logo, width/2 - logo.width/2, height/2- logo.height/2);
  noStroke();

}


float calAngle1(int x, int y, float angle) {
  
  if(x > floor(cols/2)){
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

void mouseClicked(){
  for(int i = 0; i < pCount; i++){
    Particle p = new Particle();
    p.pos = particlePoses[i].copy();
    particles = (Particle[])append(particles,p);
  }

}