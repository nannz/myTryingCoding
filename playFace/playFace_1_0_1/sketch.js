"use strict";
var o;
function setup() {
  createCanvas(500,600);
  o = new Oscillator();
}

function draw() {
  background(255);
  o.update();
  o.display();
}