"use strict";

class SpringAgent{
  constructor(agent, ballA, len){
    this.agent = agent;
    this.ballA = ballA;
    this.len = len;
    this.k = 0.5; //hook's law弹力系数
  }
  
  update(){
    var direction = p5.Vector.sub(this.ballA.pos, this.agent.pos);
    var distance = direction.mag();
    var stretch = distance - this.len;
    //hooke's law
    //mag of the spring force  = -1 * this.k * stretch;
    var force = direction.copy();
    var forceMag = -1 * this.k * stretch; 
    force.normalize();
    force.mult(forceMag);
    this.ballA.applyForce(force);

  }
  display(){
    push();
    stroke(0);
    line(this.agent.pos.x,this.agent.pos.y, this.ballA.pos.x,this.ballA.pos.y);
    pop();
  }
}