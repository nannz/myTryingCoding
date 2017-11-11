/*
b is to have an array of an array of imgInfo objects.(an array to store images info for particles positions and size)
*/


import java.util.Calendar;

PImage[] images;
String[] imageNames;
int imageCount;
//ImgInfo[] imgInfo = new ImgInfo[1]; //only for one img
//String[][] arrays = { array1, array2, array3, array4, array5 };
ImgInfo[][] imgsInfos;// = new ImgInfo[3][1];

int RESOLUTION = 50;
float IMGWIDTH = 400;

Particle[] particles = new Particle[1];

void setup() {
  size(1280, 720);
  background(255);

  File dir = new File(sketchPath(""), "../b_footage_test");

  if (dir.isDirectory()) {
    String[] contents = dir.list();
    images = new PImage[contents.length]; 
    imageNames = new String[contents.length]; 
    for (int i = 0; i < contents.length; i++) {
      // skip hidden files and folders starting with a dot, load .jpg files only
      if (contents[i].charAt(0) == '.') continue;
      else if (contents[i].toLowerCase().endsWith(".jpg")) {
        File childFile = new File(dir, contents[i]);        
        images[imageCount] = loadImage(childFile.getPath());
        imageNames[imageCount] = childFile.getName();
        println(imageCount+" "+contents[i]+"  "+childFile.getPath());
        imageCount++;
      }
    }
  }
  //update the size of the imgs array
  imgsInfos = new ImgInfo[imageCount][1];
  ImgInfo[] imgInfo = new ImgInfo[1]; 
  for (int i = 0; i < imageCount; i ++) {
    imgInfo = createImgInfo(i); 
    imgsInfos[i] = imgInfo;
  }
  //println(imgsInfos[0][0].pos.x);
  //println(imgsInfos[imageCount-1][10].pos.x);
  //int i = 1;
  for(ImgInfo imgPixel: imgsInfos[0]){
    fill(0);
    ellipse(imgPixel.pos.x, imgPixel.pos.y, 10, 10);
    //println(i + " " + imgPixel.pos.x);
    //i++;
  }
  particles = createParticles(imgsInfos[0]); //for the first image
}

void draw(){
  //background(255);
  for(Particle p : particles) {
    p.display();
  }
}


float imgBrightness;
float imgPSize;
float imgPPosX, imgPPosY;
float newX, newY;

ImgInfo[] createImgInfo(int imageIndex) {
  PImage img = images[imageIndex];
  ImgInfo[] imgInfo = new ImgInfo[1]; //initialize an imginfo
  
  img.loadPixels();
  for (int y = 0; y < img.height; y += RESOLUTION) {
    for (int x = 0; x < img.width; x += RESOLUTION) {
      int imgIndex = x + y * img.width;
      imgBrightness = brightness(img.pixels[imgIndex]);
      imgPSize = map(imgBrightness, 0, 255, 5.0, 1.0);
      newX = map(x, 0, img.width, 0, IMGWIDTH);
      newY = newX * img.width / img.height;
      imgPPosX = width/2 - IMGWIDTH/2 + newX;
      imgPPosY = height/2 - (IMGWIDTH * img.height / img.width)/2 + newY;

      ImgInfo imgI = new ImgInfo( imgPPosX, imgPPosY, imgPSize);

      if (imgInfo[0] == null) {
        imgInfo[0] = imgI;
      } else {
        imgInfo = (ImgInfo[])append(imgInfo, imgI);
      }
    }
  }
  return imgInfo;
}

Particle[] createParticles(ImgInfo[] _imgInfo){
  Particle p = new Particle();
  Particle[] particles = new Particle[1];  
  //需不需要load pixel啊
  for(ImgInfo imgPixel: _imgInfo){ //the particles we need for the img
    p.setPos(imgPixel.pos.x,imgPixel.pos.y);
    p.setSize(imgPixel.size);
    
    if(particles[0] == null){
      particles[0] = p;
    }else{
      particles = (Particle[])append(particles,p);
    }
  }
  return particles;
}