float inc = 0.1; 
int scl = 20; //scale
int cols, rows;

float zoff = 0; //the time
int noOfPoints = 2000;
Particle[] particles = new Particle[noOfPoints];
PVector[] flowField;

void setup() {
  size(1680, 1050);

  background(255);

  cols = floor(width/scl);
  rows = floor(height/scl);

  flowField = new PVector[(cols*rows)];

  for (int i = 0; i < noOfPoints; i++) {
    particles[i] = new Particle();
    //particles[i].setPos(width/2 + random(0,30), height/2+random(-15,15));
    //PVector firstForce = new PVector(random(-10,10), random(-10,10));
    //xparticles[i].applyForce(firstForce);
  }
}

void draw() {
  fill(255,50);
  rect(0, 0, width, height);
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
      
      //way2 to calculate the angle
      float angle = noise(xoff, yoff, zoff) * TWO_PI;
      angle = calAngle2(x, y, angle);
      
      PVector v = PVector.fromAngle(angle);      
      //control the speed
      v.setMag(0.05);

      flowField[index]=v;

      //drawflowField();
      pushMatrix();
      stroke(0);
      translate(x*scl, y*scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      //fill(255,0,0);
      //ellipse(0,0,3,3);
      popMatrix();

      xoff += inc;
    }
    yoff += inc;
    zoff += 0.0003;
  }
  for(int i = 0; i < particles.length; i++) {
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].edges();
    particles[i].display();
  }
  
}

float calAngle1(int x, int y, float angle) {
  if (x<= floor(cols/2) && y <= floor(rows/2)) {//左上
    angle = angle + PI;
  } else if ( x > floor(cols/2) && y <= floor(rows/2)) {//右上
    angle = TWO_PI - angle;
  } else if (x<= floor(cols/2) && y > floor(rows/2)) {//左下
    angle = PI - angle;
  } else if (x > floor(cols/2) && y > floor(rows/2)) {//右下
    angle = angle;
  } 
  return angle;
}



float calAngle2(int x, int y, float angle) {
  if (x<= floor(cols/2) && y <= floor(rows/2)) {//左上
    angle = map(angle, 0,TWO_PI, PI, PI * 3 / 2);
  } else if ( x > floor(cols/2) && y <= floor(rows/2)) {//右上
    angle = map(angle, 0,TWO_PI, PI * 3 / 2, TWO_PI);
  } else if (x<= floor(cols/2) && y > floor(rows/2)) {//左下
    angle = map(angle, 0,TWO_PI, PI/2, PI);
  } else if (x > floor(cols/2) && y > floor(rows/2)) {//右下
    angle = map(angle, 0,TWO_PI, 0,PI/2);;
  }
  return angle;
}