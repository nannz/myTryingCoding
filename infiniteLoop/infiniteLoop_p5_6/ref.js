"use strict";

class Ref{
  constructor(_x,_y,_xDir,_yDir){
    this.pos = createVector(_x,_y);
    
    this.dir = createVector(_xDir, _yDir);
    
    this.nextPos = createVector();
  }
  
  setNextPos(nextPoint){
    this.nextPos = nextPoint.copy();
    return this;
  }
}