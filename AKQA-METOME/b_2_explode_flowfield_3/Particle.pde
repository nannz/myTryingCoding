class Particle {
  PVector pos, vel, acc;
  float size, mass;
  boolean isExploded;
  float maxVel;
  float velDamping = 0.98;
  boolean isEdged;
  Particle(float _x, float _y, float _s){
    pos = new PVector(_x,_y);
    size = _s;
    mass = 1.0; // will response to the size?
    
    vel = new PVector(0,0);
    acc = new PVector(0,0);   
    maxVel = 5.0;
    isExploded = false;
    isEdged = false;
  }
  void setPos(float x,float y){
    pos.x = x;
    pos.y = y;
    return;
  }
  void setSize(float _size){
    size = _size;
    mass = map(size,0,2,2,0);
    return;
  }
  
  void applyForce(PVector force){
    force.div(mass);
    acc.add(force);
  }
  void update(){
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);
    vel.mult(velDamping);
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    fill(0);
    ellipse(0,0, size,size);
    popMatrix();
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
    PVector force = vectors[index].copy();
    applyForce(force);
  }
   void edges() {
    if(pos.x >= width || pos.x <= 0 || pos.y >= height || pos.y <= 0){
      isEdged = true;   
    }else{
      isEdged = false;   
    }
    
    if (pos.x > width-50) {
      pos.x = 50;
    }
    if (pos.x < 50) {
      pos.x = width-50;
    }

    if (pos.y > height-50) {
      pos.y = 50;
    }
    if (pos.y < 50) {
      pos.y = height-50;
    }
    
    //pos.x = constrain(pos.x, 0, width);
    //pos.y = constrain(pos.y, 0, height);
   }

}