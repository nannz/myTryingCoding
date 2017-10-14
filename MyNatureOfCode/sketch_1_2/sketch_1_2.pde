float distance;
float lengthOfRect;

void setup(){
  size(640,360);
}

void draw(){
   background(255);
 
  PVector mouse = new PVector(mouseX,mouseY);
  PVector center = new PVector(width/2,height/2);
  
  mouse.sub(center);
  
  distance = mouse.mag();
  lengthOfRect = map(distance, 0, center.mag(),0,width);
  fill(0);
  rect(0,0,lengthOfRect, 10);
  
  mouse.normalize();//get the single direction, unit of the vecctor is 1 now
  mouse.mult(50); // set hte length of the line below.
  translate(width/2,height/2);
  line(0,0,mouse.x,mouse.y);
}