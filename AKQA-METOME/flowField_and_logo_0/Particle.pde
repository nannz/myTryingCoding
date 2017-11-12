class Particle {
  PVector pos, vel, acc; 
  float maxVel;
  PVector prevPos;

  Particle() {
    pos = new PVector(random(0,width), random(0,height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    maxVel = 2.0;

    prevPos = pos.copy();
  }
  
  void setPos(float _x, float _y){
    pos.x = _x;
    pos.y = _y;
    //return this;
  }

  void update() {
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);
    
    //vel.mult(0.8);
  }
  void follow(PVector[] vectors) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    //int index = x + y * cols;
    int index = (x-1) + ((y-1) * cols);
    // Sometimes the index ends up out of range, typically by a value under 100.
    // I have no idea why this happens, but I have to do some stupid if-checking
    // to make sure the sketch doesn't crash when it inevitably happens.
    //
    index = index - 1;
    if(index > vectors.length || index < 0) {
      //println("Out of bounds!");
      //println(index);
      //println(vectors.length);
      index = vectors.length - 1;
    }
    PVector force = vectors[index];
    applyForce(force);
  }
  void applyForce(PVector force) {
    acc.add(force);
  }
  void display() {
    pushMatrix();
    //translate(pos.x, pos.y);
    //stroke(0,10);
    //strokeWeight(2);
    //point(pos.x, pos.y);
    //line(pos.x, pos.y, prevPos.x, prevPos.y);
    fill(0);
    ellipse(pos.x, pos.y, 1,1);
    popMatrix();
    updatePrev();
  }
  void updatePrev() {
    prevPos.y = pos.y;
    prevPos.x = pos.x;
  }
  void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePrev();
    }
    if (pos.x < 0) {
      pos.x = width;
      updatePrev();
    }

    if (pos.y > height) {
      pos.y = 0;
      updatePrev();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePrev();
    }
    //pos.x = constrain(pos.x, 0, width);
    //pos.y = constrain(pos.y, 0, height);
  }
}