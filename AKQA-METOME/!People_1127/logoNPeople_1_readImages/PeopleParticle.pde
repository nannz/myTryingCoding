float C_ATTRACTION = 220;
class PeopleParticle {
  PVector pos, vel, acc;
  float size, mass;
  boolean isExploded, isNext;
  int imageNo; //store which image the particle system is acting.
  float destDistance;
  float initialDistance;
  float initialSize;
  float angle, angleVel;
  float maxVel, maxSteerForce;
  
  PeopleParticle(float _x, float _y, float _s) {
    pos = new PVector(_x, _y);
    size = _s;
    mass = 1.0; // will response to the size?

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);   

    isExploded = false;
    isNext = false;
    imageNo = 0;
    initialSize = _s;

    angle = random(0.1);//PI *2);
    angleVel = random(0.5, 0.1);
    
    maxVel = 50;
    maxSteerForce = 0.4;
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
  void setImgNo(int number) {
    imageNo = number;
    return;
  }

  void applyAttraction(PVector destination) {
    PVector distance = PVector.sub(destination, pos);
    distance.setMag(maxVel);
    PVector direction = PVector.sub(distance, vel);
    //direction.normalize();
    //direction.mult(0.6);//magnitude);
    direction.limit(maxSteerForce);
    //force.mult(magnitude);
    applyForce(direction);
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
      this.angle += 0.2;
    }
  }

  void display() {
    pushMatrix();
    //translate(pos.x, pos.y); 
    fill(0, 100);
    ellipse(pos.x, pos.y, size , size);
    popMatrix();
  }
}