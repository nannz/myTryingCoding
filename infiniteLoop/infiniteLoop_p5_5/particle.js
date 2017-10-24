"use strict";

class Particle {
  constructor() {
    this.pos = createVector(0, 0);
    this.vel = createVector();
    this.acc = createVector();

    this.mass = 2; //random(1,3);
    this.rad = this.mass;
    this.c = color(random(255), random(255), random(255));
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
  follow(refParticles) {

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
    var force = refParticles[destinationPointIndex].dir;
    //force.normalize();
    //force.mult(0.01);
    
    //this.applyAttraction(refParticles[destinationPointIndex]);
    this.applyForce(force);
    //know we also have the shortest destination point to this particle.
    return destinationPointIndex;
  }
  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  display() {
    push();
    translate(this.pos.x, this.pos.y);
    fill(this.c);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    pop();
  }
}