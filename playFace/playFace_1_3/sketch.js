var balls = [];
var video;
var vScale = 16;

var bobs = [];
var lines = [];
var spring;
var gravity;

function setup() {
  createCanvas(640, 480);
  pixelDensity(1);
  video = createCapture(VIDEO);
  video.size(width / vScale, height / vScale);
  video.hide();

  for (var y = 0; y < video.height; y++) {
    for (var x = 0; x < video.width; x++) {
      var index = (x + y * video.width);
      var originPos = createVector(x * vScale, y * vScale);
      print(index);
      
      bobs[index] = new Bob(originPos.x, originPos.y + 5)
        .setDiameter(10)
        .setColour(color(255, 255, 255));

      lines[index] = new Line(originPos, 5);
    }
  }
}

function draw() {
  background(51);

  video.loadPixels();
  loadPixels();
  for (var y = 0; y < video.height; y++) {
    for (var x = 0; x < video.width; x++) {
      var index = (video.width - x + 1 + (y * video.width)) * 4;
      var ballIndex = (x + y * video.width);

      var r = video.pixels[index + 0];
      var g = video.pixels[index + 1];
      var b = video.pixels[index + 2];

      var bright = (r + g + b) / 3;
      var d = map(bright, 0, 255, 3, vScale *1.5);

      var colour = color(r, g, b);

      bobs[ballIndex].setColour(colour).setDiameter(d);
    }
  }

  for (var i = 0; i < bobs.length; i++) {
    var bob = bobs[i];
    var li = lines[i];
    
    li.connect(bob);
    li.constrainLen(bob, 30, 200);
    bob.update();
    // If it's being dragged
    var mousePos = createVector(mouseX,mouseY);
    if(p5.Vector.dist(bob.pos, mousePos) < bob.rad){
      bob.drag(mouseX,mouseY);
    }
    
    //li.displayLine(bob); // Draw a line between spring and bob
    bob.display();
  }
}

function mousePressed(){
  for (var i = 0; i < bobs.length; i++) {
    var bob = bobs[i];
    var mousePos = createVector(mouseX,mouseY);
    if(p5.Vector.dist(bob.pos, mousePos)<bob.mass){
      bob.clicked(mouseX,mouseY);
    }
  }
}
function mouseReleased(){
  for (var i = 0; i < bobs.length; i++) {
    var bob = bobs[i];
    bob.stopDragging();
  }
  
}