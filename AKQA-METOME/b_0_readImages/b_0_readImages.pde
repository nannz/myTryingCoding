import java.util.Calendar;

PImage[] images;
String[] imageNames;
int imageCount;

void setup(){
  size(1280,720); 
  //size(1024,768);
  imageMode(CENTER);
  background(255);
  
  File dir = new File(sketchPath(""),"../b_footage_test");
  
  if(dir.isDirectory()){
    String[] contents = dir.list();
    images = new PImage[contents.length]; 
    imageNames = new String[contents.length]; 
    for (int i = 0 ; i < contents.length; i++) {
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
  
  imageMode(CENTER);
  image(images[1], width/2,height/2, images[0].width * 0.2,images[0].height *0.2);
}