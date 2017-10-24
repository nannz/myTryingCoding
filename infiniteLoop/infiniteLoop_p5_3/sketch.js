"use strict";
var p;
var refParticles = [];
var STEP = 0.1;
var CO_ATTRACTION = 0.005;
function setup() {
  createCanvas(500,500);
  background(0);
  p = new Particle()
    .setPos(width/2,height/2);
 
  //create objects of the infinite loop symbol & draw
  
  createSymbol();
  print(refParticles[0].pos.x); //x=150
  
  
  for(var i = 0; i < refParticles.length; i++){
    var refP = refParticles[i];
    refP.display();
  }
 
}
function draw() {
  background(0);
  for(var i = 0; i < refParticles.length; i++){
    p.applyAttraction(refParticles[i]);
  }
  //particle
  p.update();
  p.display();
  
  
}

function createSymbol(){
  //formula
  // push();
  // translate(width/2, height/2);
  //beginShape(POINTS);
  
  for(var theta = 0.0; theta <= 2*PI; theta += STEP){
    //Lemniscate of Bernoulli ;scale = 2 / (3 - cos(2*t));x = scale * cos(t);y = scale * sin(2*t) / 2;
    
    //this vertex
    var scal = 2/(3 - cos(2 * theta)) * 150;
    var x = scal * cos(theta) + width/2;
    var y = scal * sin(2*theta)/2 + height/2;
    
    //next vertex
    var scalNext = 2/(3 - cos(2 * (theta+STEP))) * 150;
    var xNext = scal * cos(theta+STEP);
    var yNext = scal * sin(2*(theta + STEP))/2;
    
    var refP = new Particle().setPos(x,y).setColor(random(255),random(255),random(255),200);
    refParticles.push(refP);
    
    //drawLine
    //stroke(random(255),random(255),random(255));
    //strokeWeight(2);
    //line(x,y,xNext,yNext); // the line
    //vertex(x,y);
  }
  //endShape();
  // pop();
}