//SuperFormula
//www.youtube.com/watch?v=u6arTXBDYhQ

//Cartesian coordinates
//Polar coordinates (4, PI/4) //the first is the 4 of a circle, the second is the angle.
float rad;
void setup() {
  size(500, 500);

  noFill();
  stroke(255);
  strokeWeight(2);
}

float t = 0.0;

void draw() {
  background(20);

  translate(width/2, height/2);
  beginShape();
  // the smaller the theta change is(like 0.01 compared to 0.1, the smoother the shape is
  for (float theta = 0.0; theta <= 2*PI; theta += 0.01) { 
    rad = r(theta, 
    2, //mouseX / 100.0, //a // size-some points of the m
    2,//mouseY / 100.0, //b //size -the other points of the m
    6, //m //duan dian shu liang
    1,//mouseX / 100.0, //n1 //smmooth the shape <-> spisky/explode the shape
    sin(t) *1.3, //mouseX / 100.0, //n2
    cos(t) * 1.3  //mouseY / 100.0 //n3 //n2,n3 change the actual shape of the graphic
    );
    float x = rad * cos(theta)*50;
    float y = rad * sin(theta) *50;
    vertex(x, y);
  }
  endShape();
  
  t+=0.1;
}

float r(float theta, float a, float b, float m, float n1, float n2, float n3) {
  //superformula here 
  float result = pow(pow(abs(cos(m*theta/4.0) / a), n2) + 
    pow(abs(sin(m*theta/4.0) / b), n3), -1.0/n1);
  return result;
}

