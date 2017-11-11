"use strict";
class Agent{
  constructor(_theta,_transX, _transY,_m){
    var scal = 2 / (3 - cos(2 * _theta)) * 150;
    var x = scal * cos(_theta) + _transX; //点移动到中间去
    var y = scal * sin(2 * _theta) / 2 + _transY; //点移动到中间去
    this.transPoint = createVector(_transX, _transY);
    
    this.pos = createVector(x,y);
    this.theta = _theta;//0.0;
    this.STEP = 0.02;
    
    this.mass = _m;
    this.rad = this.mass
  }
  
  update() {
    var scal = 2 / (3 - cos(2 * this.theta )) * 150;
    var x = scal * cos(this.theta ) + this.transPoint.x; //点移动到中间去
    var y = scal * sin(2 * this.theta ) / 2 + this.transPoint.y; //点移动到中间去
    this.pos.x = x;
    this.pos.y = y; 
    
    this.theta += this.STEP;
    if(this.theta  > 2 *PI){
      this.theta  = 0.0;
    }
  }
  
  display() {
    push();
    translate(this.pos.x, this.pos.y);
    fill(255,0,0);
    ellipse(0, 0, this.rad*2, this.rad*2);
    pop();
  }
}