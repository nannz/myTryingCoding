"use strict";

class Particle{
  constructor(){
    this.pos = createVector(0,0);
    this.vel = createVector();
    this.acc = createVector();
    
    this.mass = random(1,3);
    this.rad = this.mass ;
  }
  
  setPos(x,y){
    this.pos = createVector(x,y);
    return this;
  }
  setVel(x,y){
    this.vel = createVector(x,y);
    return this;
  }
  
  applyForce(force){
    force.div(this.mass);
    this.acc.add(force);
  }
  
  update(){
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  display() {
    push();
    translate(this.pos.x, this.pos.y);
    fill(255);
    ellipse(0,0,this.rad * 2, this.rad * 2);
  }
}