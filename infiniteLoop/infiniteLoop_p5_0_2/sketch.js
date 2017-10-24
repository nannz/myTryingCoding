var agents = [];

var numOfBalls = 50;

function setup() {
  createCanvas(500, 500);
  background(255);

  for (var i = 0; i < numOfBalls; i++) {

    agents[i] = new Agent(0.0);
  }

}

function draw() {
  background(255,10);

  text("NAN 20171020", 400, 470);
  var mousePos = createVector(mouseX, mouseY);
 
  for (var i = 0; i < agents.length; i++) {
    var a = agents[i];
    
    var distance = p5.Vector.sub(mousePos, a.pos);
    if(distance.mag() <= 13){
      a.mouseHover = true;
      a.applyAntiAttraction(mousePos);
      //print("applied!");
    }else{
      if(a.mouseHover == true){
        //if mouse just left the anti-attraction zone
        //a.applyBackForce();
        a.mouseHover = false;
      }
    }
    //
    //print(p5.Vector.angleBetween(mousePos, agents[0].pos));
    
    a.update();
    a.display();
    //a.applyBackForce();
  }



}