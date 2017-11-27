//imgInfos[] store only 1 image!
//store all the particles' position ( in a resolution) of a single image.
//from only one image!
class ImgInfo{
  PVector pos;
  float size;
  
  ImgInfo(){
    pos= new PVector(0,0);
    size = 1.0;
  }
  ImgInfo(float x, float y, float z){
    pos= new PVector(x,y);
    size = z;
  }
}