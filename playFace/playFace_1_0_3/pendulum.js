"use strict";
class Pendulum  {
  constructor(_origin,_arm)  {
    this.originPos = createVector(_origin.x, _origin.y);
    this.pos = createVector();
    
    this.arm = _arm;
    this.angle = PI/4; //pendulum arm angle //开始的角度
    this.aVel = 0.0;
    this.aAcc = 0.0;
    this.damping = 0.995; //arbitrary damping amount
    
    this.gravity = 0.4;
    
    this.vel = createVector(random(-0.05,0.05),random(-0.05,0.05));
    this.amp = createVector(random(width/2),random(height/2));
  }
 
 update()  {
    this.aAcc = (-1 * this.gravity / this.arm) * sin(this.angle); //formula for angular acc
    
    this.aVel += this.aAcc;
    this.angle += this.aVel;
    
    this.aVel *= this.damping;
  }
 
  display()  {
    this.pos.x = this.arm * sin(this.angle);
    this.pos.y = this.arm * cos(this.angle);
    this.pos.add(this.origin);
    
    push();
    translate(this.originPos.x,this.originPos.y);
    stroke(0);
    fill(175);
    line(0,0,this.pos.x,this.pos.y);
    ellipse(this.pos.x,this.pos.y,16,16);
    pop();
  }
}