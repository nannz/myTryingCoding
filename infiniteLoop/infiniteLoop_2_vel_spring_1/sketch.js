/*add array of balls*/
//** in index.html, put defer before dat.gui.min.js, sketch.js, and particle.js

//try updating the vel with the next theta's position. work even worse!
"use strict";
var agent;
var springAgent;
//var spring;
var springs = [];
var balls = [];
var numOfBalls = 5;
var STEP = 0.02;
//create jason object for the parameters we need
var param = {
  agent: true, //boolean value, initiate value is false
  balls: true,
  road: false,
  springLine: true,
  updateBG: true,
  //gravity: 1, //comma!
  //numOfBalls: 0,
  applySpring: true,
};
var gui = new dat.gui.GUI();
gui.add(param, 'agent'); // toggle
gui.add(param, 'balls');
gui.add(param, 'road'); // toggle
gui.add(param, 'springLine'); // toggle
gui.add(param, 'updateBG');
gui.add(param, 'applySpring');

function setup() {
  createCanvas(500, 500);
  background(255);
  noStroke();

  for (var i = 0; i < numOfBalls; i++) {
    var pos = calPos(i * STEP, width / 2, height / 2);
    balls.push(new Ball(pos.x, pos.y, 5, i * STEP ));
  }

  //var posAgent = calPos(PI,width/2, height/2);
  var agentTheta = 0;
  agent = new Agent(agentTheta, width / 2, height / 2, 15);
  springAgent = new SpringAgent(agent, balls[0], 8);
  for (var i = 0; i < numOfBalls - 1; i++) {
    springs.push(new Spring(balls[i], balls[i + 1], 8));
  }
  
  for (var i = 0; i < balls.length; i++) {
    balls[i].updateVel();
  }
}

function draw() {

  if (param.updateBG) background(255);

  //road
  if (param.road) drawInfiniteLoop();

  //spring lines and forces
  springAgent.update();
  if (param.springLine) {
    springAgent.display();
  }

  if (param.applySpring) {
    for (var i = 0; i < springs.length; i++) {
      springs[i].update();
      if (param.springLine) {
        springs[i].display();
      }
    }
  }


  //red agent as the first ball
  agent.update();
  if (param.agent) {
    agent.display();
  }


  //balls
  for (var i = 0; i < balls.length; i++) {
    balls[i].update();
    if (param.balls) {
      balls[i].display();
    }
  }





}

/*
calculate a position based on the theta and the translate position
return a vector
*/
function calPos(_theta, _transX, _transY) {
  var scal = 2 / (3 - cos(2 * _theta)) * 150;
  var x = scal * cos(_theta) + _transX; //点移动到translate's point
  var y = scal * sin(2 * _theta) / 2 + _transY; //点移动到translate's point
  var pos = createVector(x, y);
  return pos;
}

function drawInfiniteLoop() {
  push();
  stroke(255, 0, 0, 50);
  //fill(0);
  beginShape();
  for (var t = 0; t < 2 * PI; t += 0.02) {
    var scal = 2 / (3 - cos(2 * t)) * 150;
    var x = scal * cos(t) + width / 2; //点移动到中间去
    var y = scal * sin(2 * t) / 2 + height / 2; //点移动到中间去
    vertex(x, y);
    //ellipse(x,y,10,10);
  }
  endShape(CLOSE);
  pop();
}