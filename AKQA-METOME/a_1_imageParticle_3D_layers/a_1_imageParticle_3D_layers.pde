/**
 read image + display the image
 */

PImage img;
int RESOLUTION = 10;
Particle[] particles = new Particle[1];

void setup() {
  size(1680, 1050, P3D);
  img = loadImage("assets/cruz_small.jpg");
  pixelDensity(displayDensity());
  background(255);
  lights();
  noStroke();
  createParticles();
}

void draw() {
  background(255);
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  
  for (Particle p : particles) {
    p.display();
  }
}

float imgBrightness;
float imgPSize;
float imgPPosX, imgPPosY, imgPPosZ;
float pSizeMin = 0.0;
float pSizeMax = 4.0;
void createParticles() {
  img.loadPixels();
  for (int y = 0; y<img.height; y += RESOLUTION) {
    for (int x = 0; x<img.width; x += RESOLUTION) {
      int imgIndex = x + y * img.width;
      imgBrightness = brightness(img.pixels[imgIndex]);
      imgPSize = map(imgBrightness, 0, 255, pSizeMax, pSizeMin);
      imgPPosZ = map(imgBrightness, 0, 255, 1, 10);
      Particle imgP = new Particle();

      imgPPosX = width/2 - img.width/2 + x;
      imgPPosY = height/2 - img.height/2 + y;   

      imgP.setPos(imgPPosX, imgPPosY, imgPPosZ);
      imgP.setSize(imgPSize);
      if (particles[0] == null) {
        particles[0] = imgP;
      } else {
        particles = (Particle[])append(particles, imgP);
      }
    }
  }
}

void drawSphere(float x, float y, float z){
  pushMatrix();
  translate(x,y,z);
  fill(255,0,0);
  sphere(5);
  popMatrix();

}