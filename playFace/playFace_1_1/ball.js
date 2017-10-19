"use strict";

class Ball{
  constructor(){
    this.pos = createVector();
    this.vel = createVector();
    this.acc = createVector();
    
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
    
  }
  
  display(){
    push();
    translate(this.pos.x, this.pos.y);
    noStroke();
    fill(this.colour);
    //ellipseMode(CENTER);
    ellipse(0, 0, this.rad * 2, this.rad * 2);
    pop();
  }
}