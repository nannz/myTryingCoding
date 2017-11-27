float t;
PVector drawAgent() {
  pushMatrix();
  translate(width/2, height/2);
  float xVal = sin(frameCount/10)*100 + sin(frameCount/5)*20;
  float yVal = cos(-frameCount/10)* 100 + sin(frameCount/5) *50;
  popMatrix();

  t+= 0.2;

  PVector agentPos = new PVector(1.2*(xVal+width/2), 1.2*(yVal+height/2));
  return agentPos;
}