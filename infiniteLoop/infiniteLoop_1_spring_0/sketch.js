"use strict";
var ballA, ballB;
var agent;
var springAgent;
var spring;

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
  background(255);
  
  drawInfiniteLoop();
  
  springAgent.update();
  springAgent.display();

  spring.update();
  spring.display();

  agent.update();
  agent.display();

  ballA.update();
  ballA.display();
  ballB.update();
  ballB.display();


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