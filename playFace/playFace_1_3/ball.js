"use strict";

class Ball{
  constructor(_origin,_arm){
    
    this.originPos = createVector(_origin.x, _origin.y);
    this.pos = createVector();
    
    this.arm = _arm;
    this.gravity = 0.2;
    
    this.vel = createVector(random(-0.05,0.05),random(-0.05,0.05));
    this.amp = createVector(random(width/2),random(height/2));
    
    this.colour = color(51,51,51);
    this.rad = 10;
  }
  
  setPos(_x,_y){
    this.pos = createVector(_x,_y);
    return this;
  }
  setDiameter(_d){
    this.rad = _d / 2;
    return this;
  }
  setColour(_colour){
    this.colour = _colour;
    return this;
  }
  
  update(){
    this.aAcc = (-1 * this.gravity / this.arm) * sin(this.angle); //formula for angular acc
    
    this.aVel += this.aAcc;
    this.angle += this.aVel;
    
    this.aVel *= this.damping;
  }
  
  display(){
    this.pos.x = this.arm * sin(this.angle);
    this.pos.y = this.arm * cos(this.angle);
    this.pos.add(this.origin);
    
    push();
    translate(this.originPos.x,this.originPos.y);
    stroke(255);
    fill(this.colour);
    //ellipseMode(CENTER);
    line(0,0,this.pos.x,this.pos.y);
    noStroke();
    ellipse(this.pos.x,this.pos.y, this.rad * 2, this.rad * 2);
    pop();
  }
}