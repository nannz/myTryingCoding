"use strict";
class Agent {
  constructor(_theta) {
    var scal = 2 / (3 - cos(2 * _theta)) * 150;
    
    
    var x = scal * cos(_theta) + width / 2; //点移动到中间去
    var y = scal * sin(2 * _theta) / 2 + height / 2; //点移动到中间去
    var ranX = random(-13,13);
    var ranY = random(-13,13);
    
    this.pos = createVector(x+ranX,y+ranY);
    this.theta = 0.0;
    this.STEP = 0.01;
  }

  // setPos(_theta) {
  //   //theta shoud 0-2*PI
  //   var scal = 2 / (3 - cos(2 * _theta)) * 150;
  //   var x = scal * cos(theta) + width / 2; //点移动到中间去
  //   var y = scal * sin(2 * theta) / 2 + height / 2; //点移动到中间去

  //   this.pos = createVector(x, y);
  // }
  
  update() {
    var scal = 2 / (3 - cos(2 * this.theta )) * 150;
    var x = scal * cos(this.theta ) + width / 2; //点移动到中间去
    var y = scal * sin(2 * this.theta ) / 2 + height / 2; //点移动到中间去
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
    noStroke();
    fill(255,0,0);
    ellipse(0, 0, 5, 5);
    pop();
  }
}