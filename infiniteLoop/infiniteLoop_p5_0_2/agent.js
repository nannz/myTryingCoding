"use strict";
class Agent {
  constructor(_theta) {
    var scal = 2 / (3 - cos(2 * _theta)) * 150;
    
    var x = scal * cos(_theta) + width / 2; //点移动到中间去
    var y = scal * sin(2 * _theta) / 2 + height / 2; //点移动到中间去
    this.ranX = random(-13,13);
    this.ranY = random(-13,13);
    
    
    this.pos = createVector(x+this.ranX,y+this.ranY);
    this.vel = createVector(0,0);
    this.acc = createVector(0,0);
    this.theta = _theta;
    this.STEP = 0.01;
    
    this.mouseHover = false;
  }
  
  applyAntiAttraction(mousePos){
    var dir = p5.Vector.sub(this.pos, mousePos);
    var angle = p5.Vector.angleBetween(this.vel, dir);
    if(angle > PI/2){
      //print("angle bigger than PI/2!");
      //dir = 
    }
    var force = dir.normalize();
    force.mult(0.8);
    this.applyForce(force);
  }
  applyBackForce(){
    var scal = 2 / (3 - cos(2 * this.theta )) * 150;
    var x = scal * cos(this.theta ) + width / 2; //点移动到中间去
    var y = scal * sin(2 * this.theta ) / 2 + height / 2; //点移动到中间去
    var backPoint = createVector(x+this.ranX,y+this.ranY);
    
    push();
    translate(backPoint.x,backPoint.y);
    noStroke();
    fill(255,0,0);
    ellipse(0, 0, 5, 5);
    pop();
  }
  applyForce(force){
    //force.div(this.mass);->suppose the mass is 1 now
    this.acc.add(force);
  }
  
  update() {
    //this particle
    var scal = 2 / (3 - cos(2 * this.theta )) * 150;
    var x = scal * cos(this.theta ) + width / 2; //点移动到中间去
    var y = scal * sin(2 * this.theta ) / 2 + height / 2; //点移动到中间去
    //next particle
    var scalNext = 2 / (3 - cos(2 * (this.theta + this.STEP))) * 150;
    var xNext = scalNext * cos(this.theta + this.STEP) + width / 2;//点移动到中间去
    var yNext = scalNext * sin(2 * (this.theta + this.STEP)) / 2 + height / 2;//点移动到中间去
    
    var thisPoint = createVector(x, y);
    var nextPoint = createVector(xNext, yNext);
    this.vel = p5.Vector.sub(nextPoint, thisPoint); //有方向有长度的
    
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    //this.pos.x = x;
    //this.pos.y = y; 
    
    this.theta += this.STEP;
    if(this.theta  > 2 *PI){
      this.theta  = 0.0;
    }
  }
  
  display() {
    push();
    translate(this.pos.x, this.pos.y);
    noStroke();
    fill(0);
    ellipse(0, 0, 3, 3);
    pop();
  }
  
  checkMouseInteraction(mousePos){
    
  }
}