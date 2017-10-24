"use strict";

class Particle {
  constructor() {
    this.pos = createVector(0, 0);
    this.vel = createVector();
    this.acc = createVector();

    this.mass = 1; //random(1,3);
    this.rad = this.mass;
    this.c = color(255,255,255);//color(random(255), random(255), random(255));
  }

  setPos(x, y) {
    this.pos = createVector(x, y);
    return this;
  }
  setVel(x, y) {
    this.vel = createVector(x, y);
    return this;
  }
  setColor(r, g, b, a) {
    this.c = color(r, g, b, a);
    return this;
  }

  applyForce(force) {
    force.div(this.mass);
    this.acc.add(force);
  }
  applyAttraction(other) {
    var force = p5.Vector.sub(other.pos, this.pos);
    force.mult(CO_ATTRACTION);
    this.acc.add(force);
  }
  
  follow(vectors) {
    var x = floor(this.pos.x / scl);
    var y = floor(this.pos.y / scl);
    var index = x + y * cols;
    var force = vectors[index];
    force.mult(0.05);
    this.applyForce(force);
  }
  
  symbolAttraction(refParticles){
    //find the point that is closest to this particle
    var shortestDist = 500.0; //随便搞个大数字
    var destinationPointIndex = 0;
    for (var i = 0; i < refParticles.length; i++) {
      var distance = p5.Vector.dist(this.pos, refParticles[i].pos);
      if (distance < shortestDist) {
        shortestDist = distance;
        destinationPointIndex = i;
      }
    }
    this.applyAttraction(refParticles[destinationPointIndex]);
  }
  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    
    //this.vel.limit(10);
  }

  display() {
    push();
    translate(this.pos.x, this.pos.y);
    fill(this.c);
    noStroke();
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    pop();
  }
  edges(){
    if(this.pos.x > width-0.5) this.pos.x = 0;
    if(this.pos.x < 0.5) this.pos.x = width;
    if(this.pos.y > height-0.5) this.pos.y = 0;
    if(this.pos.y < 0.5) this.pos.y = height;
    this.pos.x = constrain(this.pos.x,0.5,width-0.5);
    this.pos.y = constrain(this.pos.y, 0.5, height-0.5);
  }
}