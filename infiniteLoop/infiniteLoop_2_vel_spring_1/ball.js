"use strict";
class Ball{
  
  constructor(_x, _y, _m, _t){
    this.pos = createVector(_x, _y);
    this.vel = createVector(0,0);
    this.acc = createVector(0,0);
    
    this.mass = _m;
    this.rad = 10;//this.mass;
    
    this.damping = 0.97;
    
    this.c= color(0,0,0,50);
    
    this.theta = _t;
  }
  
  //try applying on the next theta.
  updateVel(){
    //calculate the next theta sub this theta 's position
    //apply the force
    //update the theta
    var nextTheta = this.theta + STEP;
    var nextPos = calPos(nextTheta, width/2, height/2);
    var force = p5.Vector.sub(nextPos,this.pos);
    force.normalize();
    force.mult(0.1);
    this.applyForce(force);
    this.theta += STEP;
  }
  
  update(){
    this.updateVel();
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    
    //damping
    this.vel.mult(this.damping);
  }
  
  drag(){
    var distance = dist(mouseX, mouseY, this.pos.x, this.pos.y);
    if(distance < this.rad && mouseIsPressed){
      this.pos.x = mouseX;
      this.pos.y = mouseY;
    }
  }
  
  applyForce(force){
    force.div(this.mass);
    this.acc.add(force);
  }
  
  display(){
    push();
    translate(this.pos.x, this.pos.y);
    fill(this.c);
    ellipse(0,0,this.rad*2, this.rad*2);
    pop();
  }
}