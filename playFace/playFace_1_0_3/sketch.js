"use strict";
var p;
var bob;
var spring;
var gravity;

function setup() {
  createCanvas(500,600);
  
  //100 is  "rest length"
  bob = new Bob(width/2,100);
  var startPos = createVector(width/2,10);
  spring = new Line(startPos,100); 
  
  gravity = createVector(0,2);
}

function draw() {
  background(255);
  
  bob.applyForce(gravity);
  spring.connect(bob);
  spring.constrainLen(bob,30,200);
  bob.update();
  // If it's being dragged
  bob.drag(mouseX,mouseY);
  
  spring.displayLine(bob); // Draw a line between spring and bob
  bob.display(); 

  // if(mouseIsPressed){
  //   bob.clicked(mouseX,mouseY);
  // }else{
  //   bob.stopDragging;
  // }
}

function mousePressed(){
  bob.clicked(mouseX,mouseY);
}
function mouseReleased(){
  bob.stopDragging();
}
