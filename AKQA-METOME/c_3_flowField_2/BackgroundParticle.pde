class BackgroundParticle extends Particle{
  PVector pos, vel, acc;
  float size, mass;
  float maxVel;
  BackgroundParticle(float _x, float _y, float _s){
    super(_x,  _y,  _s);
    pos = new PVector(_x, _y);
    size = _s;
    mass = 1.0;
    maxVel = 0.5;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);   
  }

  void update() {
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);
  }
  
  void edges() {
    if (pos.x > width) {
      pos.x = 0;
      //updatePrev();
    }
    if (pos.x < 0) {
      pos.x = width;
      //updatePrev();
    }

    if (pos.y > height) {
      pos.y = 0;
      //updatePrev();
    }
    if (pos.y < 0) {
      pos.y = height;
      //updatePrev();
    }
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }
  void applyForce(PVector force) {
    force.div(mass);
    acc.add(force);
  }
  void follow(PVector[] vectors) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    //int index = x + y * cols;
    int index = (x-1) + ((y-1) * cols);
    // Sometimes the index ends up out of range, typically by a value under 100.
    // I have no idea why this happens, but I have to do some stupid if-checking
    // to make sure the sketch doesn't crash when it inevitably happens.
    index = index - 1;
    if (index > vectors.length || index < 0) {
      index = vectors.length - 1;
    }
    PVector force = vectors[index];
    applyForce(force);
  }
  void display() {
    pushMatrix();
    //translate(pos.x, pos.y);

    fill(0, 100);
    ellipse(pos.x, pos.y, size, size);
    popMatrix();
  }
}