/*add GUI for debugging*/
//** in index.html, put defer before dat.gui.min.js, sketch.js, and particle.js

"use strict";
var ballA, ballB;
var agent;
var springAgent;
var spring;

//create jason object for the parameters we need
var param = {
  agent: true, //boolean value, initiate value is false
  balls: true,
  road: false,
  springLine: true,
  updateBG:true
  //gravity: 1, //comma!
  //numOfBalls: 0,
};
var gui = new dat.gui.GUI();
gui.add(param, 'agent'); // toggle
gui.add(param, 'balls'); 
gui.add(param, 'road'); // toggle
gui.add(param, 'springLine'); // toggle
gui.add(param, 'updateBG');
//gui.add(param, 'gravity', 0, 1.5, 0.1); //min value, max value, increment step
//gui.add(param, 'wind', -1.0, 1.0, 0.1); //min value, max value, step
//gui.add(param, 'numOfParticles').listen(); //listen!
//gui.add(param, 'addParticle');

function setup() {
  createCanvas(500, 500);
  background(255);
  noStroke();

  var posA = calPos(0, width / 2, height / 2);
  var posB = calPos(0.02, width / 2, height / 2);
  ballA = new Ball(posA.x, posA.y, 5); //pos.x,pos.y,mass
  ballB = new Ball(posB.x, posB.y, 5);

  //var posAgent = calPos(PI,width/2, height/2);
  agent = new Agent(0, width / 2, height / 2, 15);

  springAgent = new SpringAgent(agent, ballA, 15);
  spring = new Spring(ballA, ballB, 15);
  
}

function draw() {
  
  if(param.updateBG)background(255);
  
  //road
  if(param.road) drawInfiniteLoop();
  
  //spring lines and forces
  springAgent.update();
  spring.update();
  if(param.springLine) {
    springAgent.display();
    spring.display();
  }

  //red agent as the first ball
  agent.update();
  if(param.agent) {
    agent.display();
  }

  //balls
  ballA.update();
  ballB.update();
  
  if(param.balls){
    ballA.display();
    ballB.display();
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
  stroke(255,0,0,50);
  //fill(0);
  beginShape();
  for (var t=0; t < 2 * PI; t += 0.02) {
    var scal = 2 / (3 - cos(2 * t)) * 150;
    var x = scal * cos(t) + width / 2; //点移动到中间去
    var y = scal * sin(2 * t) / 2 + height / 2; //点移动到中间去
    vertex(x, y);
    //ellipse(x,y,10,10);
  }
  endShape(CLOSE);
  pop();
}