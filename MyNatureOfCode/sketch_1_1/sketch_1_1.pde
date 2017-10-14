
PVector direction;
PVector location;
float r = 5;
float bouncing = 300;
Walker walker;
float rotate = 0.5;

void setup() {

  size(800, 800, P3D);
  background(255);
  direction = new PVector(0.5, 1, 1);
  location = new PVector(400, 400, 400);
  walker = new Walker(location, r, direction, bouncing); 

}

void draw() {
  background(255);
  rotateY(rotate);
  
  walker.drawBouncing();
  walker.drawWalker();
  walker.updateLocation();
  
  rotate += 0.01;
}