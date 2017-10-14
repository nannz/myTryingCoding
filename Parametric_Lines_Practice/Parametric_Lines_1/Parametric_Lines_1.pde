//Parametric_lines

//x = 5t
//y = 3t+3
//apply t, get both x and y 

float t;


void setup(){
  background(20);
  size(500,500);
}

void draw(){
  stroke(255);
  strokeWeight(5);
  
  translate(width/2, height/2);
  point(x(t),y(t));
  
  t++;

}

//x->sin y-> cos => circle
//x-> sin1+sin2 can get a nearly circle but different shapes -> interesting!
//inside the sin() changes the frequency
//outside the sin, change the ampitude 
//better to have lower ampitude if your frequency is higher.

float x(float t){
  return sin(t/10)*100 + sin(t/15)*100; 
}
float y(float t){
  return cos(t/10)* 100; //devide t means lower the frequency ; multiply t means higher the frequency
}
