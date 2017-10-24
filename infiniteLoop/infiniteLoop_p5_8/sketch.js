"use strict";
var p;
var particles = [];
var refParticles = [];
var STEP = 0.1;
var CO_ATTRACTION = 0.0001;

var scl = 10; //scale
var cols, rows;

var dirField = [];

function setup() {
  createCanvas(500, 500);
  cols = floor(width / scl);
  rows = floor(height / scl); //floor得最近整数

  background(0);

  //create particles
  //p = new Particle().setPos(50, 50);
  for (var x = 0; x < cols; x ++) {
    var p = new Particle().setPos(x * scl, 1);
    particles.push(p);
  }
  for(var y = 0; y < rows; y++){
    var p = new Particle().setPos(1, y * scl);
    particles.push(p);
  }
  for (var x = 0; x < cols; x ++) {
    var p = new Particle().setPos(x * scl, height-1);
    particles.push(p);
  }
  for(var y = 0; y < rows; y++){
    var p = new Particle().setPos(width-1, y * scl);
    particles.push(p);
  }

  //create objects of the infinite loop symbol
  createSymbol();
  //drawSymbol
  //drawSymbol();

}

function draw() {
  background(0,5);

  //grids
  for (var y = 0; y < rows; y++) {
    for (var x = 0; x < cols; x++) {
      var index = (x + y * cols);

      var gridPos = createVector(x * scl, y * scl);
      var gShortestDist = 500.0; //随便搞个大数字
      var gDestinationPointIndex = 0;
      for (var i = 0; i < refParticles.length; i++) {
        var distance = p5.Vector.dist(gridPos, refParticles[i].pos);
        //find 最近的点
        if (distance < gShortestDist) {
          gShortestDist = distance;
          gDestinationPointIndex = i;
        }
      }
      //检查是不是在column里
      var v = createVector(0, 0);
      var closestPoint = refParticles[gDestinationPointIndex];

      var v1 = p5.Vector.sub(closestPoint.pos, gridPos);
      var v2 = p5.Vector.sub(closestPoint.nextPos, gridPos);
      v = p5.Vector.sub(v2,v1);


      
      if(closestPoint.pos.x > x*scl && closestPoint.pos.x <= (x * scl + cols) 
        && closestPoint.pos.y > y*scl && closestPoint.pos.y <= (y * scl + rows)){
        //if in the column
        //v = closestPoint.dir;
        //v.mult(0);
      }
      // }else{
      //   v = p5.Vector.sub(closestPoint.pos, gridPos);
      // } 
      

      v.normalize();
      //v.mult(10);
      dirField[index] = v;

      //draw grids
      push();
      translate(x * scl, y * scl);
      stroke(70);
      strokeWeight(0.1);
      rotate(v.heading());
      line(0, 0, scl, 0);
      pop();
    }
  }

  //drawSymbol
  //drawSymbol();

  //particle
  for (var i = 0; i < particles.length; i++) {
    var p = particles[i];
    p.follow(dirField);
    p.symbolAttraction(refParticles);
    p.update();
    p.display();
    p.edges();
  }

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
    var xNext = scalNext * cos(theta + STEP) + width / 2; //点移动到中间去
    var yNext = scalNext * sin(2 * (theta + STEP)) / 2 + height / 2; //点移动到中间去

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

function drawSymbol(){
  for (var i = 0; i < refParticles.length; i++) {
    var ref = refParticles[i];
    //画一画测试一下
    push();
    fill(255);
    stroke(70);
    //ellipse(ref.pos.x, ref.pos.y, 10,10);
    line(ref.pos.x, ref.pos.y, ref.nextPos.x, ref.nextPos.y);
    pop();
  }
}