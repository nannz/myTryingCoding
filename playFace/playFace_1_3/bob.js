"use strict";
var dragging = false;
class Bob{
  constructor(x,y){
    this.pos = createVector(x,y);
    this.vel = createVector();
    this.acc = createVector();
    
    this.colour = color(255,255,255);
    this.rad = 10;
    this.mass = this.rad;//map(rad,0, vScale,0, vScale);
    
    this.dragOffset = createVector();
    this.damping = 0.98;
  }
  
  setDiameter(_d){
    this.rad = _d / 2;
    return this;
  }
  setColour(_colour){
    this.colour = _colour;
    return this;
  }
  
  applyForce(force){
    force.div(this.mass);
    this.acc.add(force);
  }
  applyGravity(){
    var g = createVector(0, this.gravity);
    this.applyForce(g);
  }
  update(){
    //this.mass = this.rad;
    
    this.applyGravity();
    
    this.vel.add(this.acc);
    this.vel.mult(this.damping);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  display(){
    push();
    translate(this.pos.x, this.pos.y);
    noStroke();
    fill(this.colour);
    ellipse(0,0,this.rad*2,this.rad*2);
    pop();
  }

  // This checks to see if we clicked on the mover
  clicked(mx,my){
    var mousePos = createVector(mx,my);
    var d = p5.Vector.dist(mousePos,this.pos);
    if(d < this.rad){
      dragging = true;
      this.dragOffset.x = this.pos.x - mx;
      this.dragOffset.y = this.pos.y - my;
    }
  }
  stopDragging() {
    dragging = false;
  }
  drag( mx,  my) {
    if (dragging) {
      this.pos.x = mx + this.dragOffset.x;
      this.pos.y = my + this.dragOffset.y;
    }
  }
  
}