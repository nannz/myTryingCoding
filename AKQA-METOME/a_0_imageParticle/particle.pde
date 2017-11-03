class Particle{
  PVector pos, vel, acc;
  float size,mass;
  color colour;
  
  Particle(){
    pos = new PVector(0,0);
    vel = new PVector(0,0,0);
    acc = new PVector(0,0,0);
    
    size = 2.0;
    mass = 1.0;
    colour = color(0,0,0);
  }
  
  void setPos(float x,float y){//, float z){
    pos.x = x;
    pos.y = y;
    //pos.z = z;
    return;
  }
  void setSize(float _size){
    size = _size;
    mass = map(size,0,2,2,0);
    return;
  }
  
  void update(){}
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);//, pos.z);
    fill(colour);
    ellipse(0,0, size,size);
    popMatrix();
  }  


}