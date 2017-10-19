"use strict";
class Oscillator  {
  constructor()  {
    this.angle = createVector();
    this.vel = createVector(random(-0.05,0.05),random(-0.05,0.05));
    this.amp = createVector(random(width/2),random(height/2));
  }
 
 update()  {
    this.angle.add(this.vel);
  }
 
  display()  {
    var x = sin(this.angle.x)*this.amp.x;
    var y = sin(this.angle.y)*this.amp.y;
 
    push();
    translate(width/2,height/2);
    stroke(0);
    fill(175);
    line(0,0,x,y);
    ellipse(x,y,16,16);
    pop();
  }
}