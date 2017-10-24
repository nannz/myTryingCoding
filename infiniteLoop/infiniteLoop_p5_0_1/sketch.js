var a;
var agents = [];

var theta = 0.0;
var STEP = 0.01;
var randomPositionX = [];
var randomPositionY = [];
var numOfBalls = 10;

function setup() {
  createCanvas(500, 500);
  background(255);

  for (var i = 0; i < numOfBalls; i++) {
    randomPositionX[i] = random(-13, 13);
    randomPositionY[i] = random(-13, 13);

    agents[i] = new Agent(0.0);
  }

}

function draw() {
  background(255); //,10);

  text("NAN 20171017", 400, 470);
  var scal = 2 / (3 - cos(2 * theta)) * 150;
  var x = scal * cos(theta);
  var y = scal * sin(2 * theta) / 2;

  //push();
  //translate(width / 2, height / 2);
  noStroke();
  fill(0);
  for (var i = 0; i < agents.length; i++) {
    var a = agents[i];
    a.display();
    a.update();
  }
  //pop();

  theta += STEP;

  if (theta > 2 * PI) {
    theta = 0.0;
  }


}