/*add array of balls*/
//** in index.html, put defer before dat.gui.min.js, sketch.js, and particle.js

//apply the on-going force according to the prev ball to update the velocity. doesn't work well

"use strict";
var C_GRAVITY = 0.1;

var agent;
var springAgent;
//var spring;
var springs = [];
var balls = [];
var numOfBalls = 5;
var STEP = 0.02;
//create jason object for the parameters we need
var param = {
  agent: false, //boolean value, initiate value is false
  balls: false,
  road: false,
  springLine: true,
  updateBG: true,
  //gravity: 1, //comma!
  //numOfBalls: 0,
  applySpring: true,
  showVel: true
};
var gui = new dat.gui.GUI();
gui.add(param, 'agent'); // toggle
gui.add(param, 'balls');
gui.add(param, 'road'); // toggle
gui.add(param, 'springLine'); // toggle
gui.add(param, 'updateBG');
gui.add(param, 'applySpring');
gui.add(param, 'showVel');

function setup() {
  createCanvas(500, 500);
  background(255);
  noStroke();

  for (var i = 0; i < numOfBalls; i++) {
    var pos = calPos(i * STEP, width / 2, height / 2);
    balls.push(new Ball(pos.x, pos.y, 5));
  }

  //var posAgent = calPos(PI,width/2, height/2);
  agent = new Agent(0, width / 2, height / 2, 15);
  springAgent = new SpringAgent(agent, balls[0], 4);
  for (var i = 0; i < numOfBalls - 1; i++) {
    springs.push(new Spring(balls[i], balls[i + 1], 4));
  }
  
  //set initial velocity
  var balltemp = new Ball(agent.pos.x, agent.pos.y, 5);
  balls[0].updateVel(balltemp);
  for (var i = 1; i < balls.length; i++) {
    balls[i].updateVel(balls[i - 1]);
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

  var balltemp = new Ball(agent.pos.x, agent.pos.y, 5);
  balls[0].updateVel(balltemp);
  for (var i = 1; i < balls.length; i++) {
    balls[i].updateVel(balls[i - 1]);
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