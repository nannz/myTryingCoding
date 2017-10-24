"use strict";
var p;
var refParticles = [];
var STEP = 0.1;
var CO_ATTRACTION = 0.0001;

function setup() {
  createCanvas(500, 500);
  background(0);
  p = new Particle()
    .setPos(50, 50);

  //create objects of the infinite loop symbol
  createSymbol();
  
  for (var i = 0; i < refParticles.length; i++) {
    var ref = refParticles[i];
    print(ref.dir.x); //x=150
    //画一画测试一下
    push();
    fill(255);
    stroke(255);
    //ellipse(ref.pos.x, ref.pos.y, 10,10);
    line(ref.pos.x,ref.pos.y,ref.nextPos.x,ref.nextPos.y);
    pop();
  }

}

function draw() {
  //background(0);
  for (var i = 0; i < refParticles.length; i++) {
    p.applyAttraction(refParticles[i]);
  }
  //particle
  p.follow(refParticles);
  p.update();
  p.display();


}

function createSymbol() {
  //每个点都有下一个的
  for (var theta = 0.0; theta <= 2 * PI; theta += STEP) {
    //Lemniscate of Bernoulli ;scale = 2 / (3 - cos(2*t));x = scale * cos(t);y = scale * sin(2*t) / 2;

    //this vertex
    var scal = 2 / (3 - cos(2 * theta)) * 150;
    var x = scal * cos(theta) + width / 2;//点移动到中间去
    var y = scal * sin(2 * theta) / 2 + height / 2;//点移动到中间去

    //next vertex
    var scalNext = 2 / (3 - cos(2 * (theta + STEP))) * 150;
    var xNext = scalNext * cos(theta + STEP) + width / 2;//点移动到中间去
    var yNext = scalNext * sin(2 * (theta + STEP)) / 2 + height / 2;//点移动到中间去

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