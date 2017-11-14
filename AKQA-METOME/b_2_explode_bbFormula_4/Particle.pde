class Particle {
  PVector pos, vel, acc;
  float size, mass;
  boolean isExploded;

  Particle(float _x, float _y, float _s) {
    pos = new PVector(_x, _y);
    size = _s;
    mass = 1.0; // will response to the size?

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);   

    isExploded = false;
  }
  void setPos(float x, float y) {
    pos.x = x;
    pos.y = y;
    return;
  }
  void setSize(float _size) {
    size = _size;
    mass = map(size, 0, 2, 2, 0);
    return;
  }

  void applyForce(PVector force) {
    force.div(mass);
    acc.add(force);
  }
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);


    if (isExploded == true) {
      //vel.mult(0.98);
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