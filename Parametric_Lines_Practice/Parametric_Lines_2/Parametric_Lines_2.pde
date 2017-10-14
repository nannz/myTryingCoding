//Parametric_lines

//x = 5t
//y = 3t+3
//apply t, get both x and y 

float t;
static final int NUM_LINES = 10;

void setup(){
  background(20);
  size(500,500);
}

void draw(){
  background(20);
  stroke(255);
  strokeWeight(5);
  
  translate(width/2, height/2);
  //point(x1(t),y1(t));
  //point(x2(t),y2(t));
  //connect two points to draw lines
  //line(x1(t),y1(t),x2(t),y2(t));
  for(int i = 0; i < NUM_LINES; i++){
    line(x1(t+i),y1(t+i),x2(t+i),y2(t+i));
  }
  
  t+=0.5; //control the speed

}


//x->sin y-> cos => circle
//x-> sin1+sin2 can get a nearly circle but different shapes -> interesting!
//inside the sin() changes the frequency
//outside the sin, change the ampitude 
//better to have lower ampitude if your frequency is higher.

//two sets of parametrics
//play around with it!
float x1(float t){
  return sin(t/10)*100 + sin(t/5)*20; 
}
float y1(float t){
  return cos(-t/10)* 100 + sin(t/5) *50; //devide t means lower the frequency ; multiply t means higher the frequency
}

float x2(float t){
  return sin(t/10)*200 + sin(t)*2 + sin(t) *10; 
}
float y2(float t){
  return cos(t/20)* 200 + cos(t/12)*20; //devide t means lower the frequency ; multiply t means higher the frequency
}
