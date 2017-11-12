"use strict";

class Spring{
  constructor(ballA, ballB, len){
    this.ballA = ballA;
    this.ballB = ballB;
    this.len = len;
    this.k = 0.5; //hook's law弹力系数
  }
  
  update(){
    var direction = p5.Vector.sub(this.ballB.pos, this.ballA.pos);
    var distance = direction.mag();
    var stretch = distance - this.len;
    //hooke's law
    //mag of the spring force  = -1 * this.k * stretch;
    var force = direction.copy();
    var forceMag = -1 * this.k * stretch; 
    force.normalize();
    force.mult(forceMag);
    this.ballB.applyForce(force);
    
    force.mult(-1);
    this.ballA.applyForce(force);
  }
  display(){
    push();
    stroke(0);
    line(this.ballA.pos.x,this.ballA.pos.y, this.ballB.pos.x,this.ballB.pos.y);
    pop();
  }
}