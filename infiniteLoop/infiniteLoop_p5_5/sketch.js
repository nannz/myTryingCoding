"use strict";
var p;
var refParticles = [];
var STEP = 0.1;
var CO_ATTRACTION = 0.0001;

var scl = 10; //scale
var cols, rows;

function setup() {
  createCanvas(500, 500);
  cols = floor(width / scl);
  rows = floor(height / scl); //floor得最近整数

  background(0);
  p = new Particle()
    .setPos(50, 50);

  //create objects of the infinite loop symbol
  createSymbol();
  //drawSymbol
  for (var i = 0; i < refParticles.length; i++) {
    var ref = refParticles[i];
    //print(ref.dir.x); //x=150
    //画一画测试一下
    push();
    fill(255);
    stroke(255);
    //ellipse(ref.pos.x, ref.pos.y, 10,10);
    line(ref.pos.x, ref.pos.y, ref.nextPos.x, ref.nextPos.y);
    pop();
  }

}

function draw() {
  background(0);

  //grids
  var yoff = 0;
  for (var y = 0; y < rows; y++) {
    var xoff = 0;
    for (var x = 0; x < cols; x++) {
      var index = (x + y * width) * 4;

      var gridPos = createVector(x * scl, y * scl);
      var gShortestDist = 500.0; //随便搞个大数字
      var gDestinationPointIndex = 0;
      for (var i = 0; i < refParticles.length; i++) {
        var distance = p5.Vector.dist(gridPos, refParticles[i].pos);
        if (distance < gShortestDist) {
          gShortestDist = distance;
          gDestinationPointIndex = i;
        }
      }
      var v = p5.Vector.sub(refParticles[gDestinationPointIndex].pos, gridPos);
      v.normalize();
      v.mult(10);

      //draw grids
      push();
      translate(x * scl, y * scl);
      stroke(255, 100);
      rotate(v.heading());
      //line(0, 0, 0, scl);
      line(0, 0, scl, 0);
      pop();
    }
    //drawSymbol
    for (var i = 0; i < refParticles.length; i++) {
      var ref = refParticles[i];
      //画一画测试一下
      push();
      fill(255);
      stroke(255);
      //ellipse(ref.pos.x, ref.pos.y, 10,10);
      line(ref.pos.x, ref.pos.y, ref.nextPos.x, ref.nextPos.y);
      pop();
    }
  }


  for (var i = 0; i < refParticles.length; i++) {
    //p.applyAttraction(refParticles[i]);
  }
  //particle
  //.p.follow(refParticles);
  p.update();
  p.display();


}

function createSymbol() {
  //每个点都有下一个的
  for (var theta = 0.0; theta <= 2 * PI; theta += STEP) {
    //Lemniscate of Bernoulli ;scale = 2 / (3 - cos(2*t));x = scale * cos(t);y = scale * sin(2*t) / 2;

    //this vertex
    var scal = 2 / (3 - cos(2 * theta)) * 150;
    var x = scal * cos(theta) + width / 2; //点移动到中间去
    var y = scal * sin(2 * theta) / 2 + height / 2; //点移动到中间去

    //next vertex
    var scalNext = 2 / (3 - cos(2 * (theta + STEP))) * 150;
    var xNext = scal * cos(theta + STEP) + width / 2; //点移动到中间去
    var yNext = scal * sin(2 * (theta + STEP)) / 2 + height / 2; //点移动到中间去

    var thisPoint = createVector(x, y);
    var nextPoint = createVector(xNext, yNext);
    var direction = p5.Vector.sub(nextPoint, thisPoint); //有方向有长度的
    // direction.normalize();
    // direction.mult(0.5);
    var refP = new Ref(thisPoint.x, thisPoint.y, direction.x, direction.y);
    refP.setNextPos(nextPoint);
    refParticles.push(refP);

  }
}