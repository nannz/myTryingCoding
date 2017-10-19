var balls = [];
var video;

var vScale = 16;

function setup() {
  createCanvas(640 /2, 480 /2);
  pixelDensity(1);
  video = createCapture(VIDEO);
  video.size(width/vScale, height/vScale);
  video.hide();
  
  for (var y = 0; y < video.height; y++) {
    for (var x = 0; x < video.width; x++) {
      var index =(x + y * video.width) ;
      var originPos = createVector(x*vScale, y*vScale);
      print(index);
      balls[index] = new Ball(originPos,5)
        .setDiameter(10)
        .setColour(color(255,255,255));
    }
  }
}

function draw() {
  background(51);

  video.loadPixels();
  loadPixels();
  for (var y = 0; y < video.height; y++) {
    for (var x = 0; x < video.width; x++) {
      var index = (video.width - x + 1 + (y * video.width))*4;
      var ballIndex = (x + y * video.width);
      
      var r = video.pixels[index+0];
      var g = video.pixels[index+1];
      var b = video.pixels[index+2];

      var bright = (r+g+b)/3;
      var d = map(bright, 0, 255, 0, vScale);
      
      var colour = color(r,g,b);
      
      balls[ballIndex].setColour(colour).setDiameter(d);
    }
  }
  
  for(var i = 0; i < balls.length; i++){
    var ball = balls[i];
    ball.update();
    ball.display();
  }
 
}


