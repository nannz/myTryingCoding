"use strict";
var p;
function setup() {
  createCanvas(500,600);
  p = new Pendulum(createVector(width/2,10),125);
}

function draw() {
  background(255);
  p.update();
  p.display();
}