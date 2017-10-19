"use strict";

class Line{
  constructor(originPos,l){
    this.startPos = createVector(originPos.x,originPos.y);
    this.len = l;
    
    this.k = 0.2; //弹力系数
  }
  
  connect(bob){
    var force = p5.Vector.sub(bob.pos, this.startPos);
    var distance = force.mag();
    var stretch = distance - this.len;
    
    //formula: F = k * stretch
    force.normalize();
    force.mult(-1 * this.k * stretch);
    bob.applyForce(force);
  }
  
  constrainLen(bob, minLen, maxLen){
    var dir = p5.Vector.sub(bob.pos, this.startPos);
    var d = dir.mag();
    
    //is it too short?
    if ( d < minLen){
      dir.normalize();
      dir.mult(minLen);
      
      bob.pos = p5.Vector.add(this.startPos, dir);
      bob.vel.mult(0);
    }else if(d > maxLen){
      //is it too long?
      dir.normalize();
      dir.mult(maxLen);
      
      bob.pos = p5.Vector.add(this.startPos, dir);
      bob.vel.mult(0);
    }
  }
  
  display(){
    push();
    translate(this.startPos.x, this.startPos.y);
    //画一个起始点
    pop();
  }
  
  displayLine(bob){
    push();
    //translate(this.startPos.x, this.startPos.y);
    stroke(0);
    line(this.startPos.x, this.startPos.y,bob.pos.x, bob.pos.y);
    pop();
  }
}