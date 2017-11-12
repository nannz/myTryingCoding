//sin/cos pattern

void setup(){
  size(500,500);
  background(255);
  noStroke();
  smooth();
}

void draw(){
    //background(0);
  // translate(width / 2, height / 2);
  //rotate(frameCount * 0.01);

  //for (var angle = 0; angle < 360; angle += 72) {//apply this forloop will make the gradient fill clearer.
    pushMatrix();
    translate(width/2, height/2);
    
    //rotate((radians(angle)+frameCount)*0.01);
    rotate(frameCount * 0.01);
    
    float freq, amp;
    freq = frameCount * 0.01;
    amp = 200;
    //sinVal = sin(freq)*amp;
    float sinVal = noise(freq) * amp;

    freq = frameCount * 0.015;
    //var amp = 100;
    amp = sinVal; //frameCount * 0.1;
    float distance = sin(freq) * amp; //100;

    //drawLine for the gradient fill of the shape.
    stroke(0, 10);
    line(0, 0, distance, 0);
    fill(0);
    ellipse(distance, 0, 1, 1);
    popMatrix();
  //}

}