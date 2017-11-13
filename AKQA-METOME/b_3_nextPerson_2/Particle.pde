float C_ATTRACTION = 220;

class Particle {
  PVector pos, vel, acc;
  float size, mass;
  boolean isExploded, isNext;
  int imageNo; //store which image the particle system is acting.
  Particle(float _x, float _y, float _s) {
    pos = new PVector(_x, _y);
    size = _s;
    mass = 1.0; // will response to the size?

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);   

    isExploded = false;
    isNext = false;
    imageNo = 0;
  }
  void setPos(float x, float y) {
    pos.x = x;
    pos.y = y;
    return;
  }
  void setSize(float _size) {
    size = _size;
    mass = map(size, 0, imgPSize_MAX, 2, 0);
    return;
  }
  void setImgNo(int number){
    imageNo = number;
    return;
  }

  void applyAttraction(ImgInfo destImgP){
    float distance = pos.dist(destImgP.pos);
    //float destMass = map(destImgP.size, 0, imgPSize_MAX, 2, 0);
    //float magnitude = (C_ATTRACTION * mass * destMass)/(distance * distance);
    PVector force = PVector.sub(destImgP.pos, this.pos);
    force.normalize();
    force.mult(distance * 0.05);//magnitude);
    applyForce(force);
  }
  
  void applyForce(PVector force) {
    force.div(mass);
    acc.add(force);
  }
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);


    if (isNext == true) {
      vel.mult(0.8);
    }
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(0);
    ellipse(0, 0, size, size);
    popMatrix();
  }
}