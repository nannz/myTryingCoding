/**
read image + display the image
*/

PImage img;
int RESOLUTION = 10;
Particle[] particles = new Particle[1];

void setup(){
  size(1680,1050);
  img = loadImage("assets/cruz_small.jpg");
  //colorMode(HSB);
  pixelDensity(displayDensity());
  background(255);
  
  //imageMode(CENTER);
  //image(img, width/2,height/2, img.width,img.height);
  
  createParticles();
}

void draw(){
  background(255);
  for(Particle p : particles) {
    p.display();
  }
}

float imgBrightness;
float imgPSize;
float imgPPosX, imgPPosY;

void createParticles(){
  img.loadPixels();
  //float brightness;
  for (int y = 0; y<img.height; y += RESOLUTION){
    for(int x = 0; x<img.width; x += RESOLUTION){
      int imgIndex = x + y * img.width;
      imgBrightness = brightness(img.pixels[imgIndex]);
      imgPSize = map(imgBrightness, 0, 255, 5.0, 1.0);
      Particle imgP = new Particle();
      
      imgPPosX = width/2 - img.width/2 + x;
      imgPPosY = height/2 - img.height/2 + y;
      imgP.setPos(imgPPosX,imgPPosY);
      imgP.setSize(imgPSize);
      if(particles[0] == null){
        particles[0] = imgP;
      }else{
        particles = (Particle[])append(particles,imgP);
      }
    }
  }
}