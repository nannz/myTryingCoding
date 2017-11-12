"use strict";
class Ball {

  constructor(_x, _y, _m) {
    this.pos = createVector(_x, _y);
    this.vel = createVector(0, 0);
    this.acc = createVector(0, 0);

    this.mass = _m;
    this.rad = 10; //this.mass;

    this.damping = 0.97;

    this.c = color(0, 0, 0, 50);

  }

  //try setting initial vel
  updateVel(prevBall) {
    var force = p5.Vector.sub(prevBall.pos, this.pos);
    var distance = this.pos.dist(prevBall.pos);
    var VEL_C = map(distance, 0, 100, 0.3, 1.5);
    force.normalize();
    force.mult(VEL_C);
    this.applyForce(force);

    if (param.showVel) {
      push();
      translate(this.pos.x, this.pos.y);
      stroke(255,0,0);
      line(0, 0, force.x * 150, force.y * 150);
      pop();
    }
  }

  applyAttraction(prevBall) {
    var distance = this.pos.dist(prevBall.pos);
    var magnitude = (C_GRAVITY * this.mass * prevBall.mass) / (distance * distance); //the formula: (G * a.m * b.m) / (distance * distance);
    var force = p5.Vector.sub(prevBall.pos, this.pos); //get the attraction force direction and mad. p1-->p2
    force.normalize();
    force.mult(magnitude);
    this.applyForce(force);
  }

  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);

    //damping
    this.vel.mult(this.damping);
  }

  drag() {
    var distance = dist(mouseX, mouseY, this.pos.x, this.pos.y);
    if (distance < this.rad && mouseIsPressed) {
      this.pos.x = mouseX;
      this.pos.y = mouseY;
    }
  }

  applyForce(force) {
    force.div(this.mass);
    this.acc.add(force);
  }

  display() {
    push();
    translate(this.pos.x, this.pos.y);
    fill(this.c);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    pop();
  }

}