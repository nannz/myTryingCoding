"use strict";
var dragging = false;
class Bob{
  constructor(x,y){
    this.pos = createVector(x,y);
    this.vel = createVector();
    this.acc = createVector();
    this.colour = color(255,255,255);
    this.rad = 10;
    this.mass = 10;
    
    this.dragOffset = createVector();
    this.damping = 0.98;
  }
  
  
  applyForce(force){
    force.div(this.mass);
    this.acc.add(force);
  }
  
  update(){
    this.vel.add(this.acc);
    this.vel.mult(this.damping);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  display(){
    push();
    translate(this.pos.x, this.pos.y);
    fill(175);
    ellipse(0,0,this.mass*2,this.mass*2);
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