void createParticlePoses() {
  for (int i = 0; i< logo.getChild(0).getVertexCount(); i++) {
    PVector v = logo.getChild(0).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i] = v.copy();
  }
  for (int i = 0; i< logo.getChild(1).getVertexCount(); i++) {
    PVector v = logo.getChild(1).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()] = v.copy();
  }
  for (int i = 0; i< logo.getChild(2).getVertexCount(); i++) {
    PVector v = logo.getChild(2).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()+logo.getChild(1).getVertexCount()] = v.copy();
  }
  for (int i = 0; i< logo.getChild(3).getVertexCount(); i++) {
    PVector v = logo.getChild(3).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()+logo.getChild(1).getVertexCount()+logo.getChild(2).getVertexCount()] = v.copy();
  }
  for (int i = 0; i< logo.getChild(4).getVertexCount(); i++) {
    PVector v = logo.getChild(4).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()+logo.getChild(1).getVertexCount()
      +logo.getChild(2).getVertexCount()+logo.getChild(3).getVertexCount()] = v.copy();
  }
  for (int i = 0; i< logo.getChild(5).getVertexCount(); i++) {
    PVector v = logo.getChild(5).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()+logo.getChild(1).getVertexCount()
      +logo.getChild(2).getVertexCount()+logo.getChild(3).getVertexCount()
      +logo.getChild(4).getVertexCount()] = v.copy();
  }
  for (int i = 0; i< logo.getChild(6).getVertexCount(); i++) {
    PVector v = logo.getChild(6).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()+logo.getChild(1).getVertexCount()
      +logo.getChild(2).getVertexCount()+logo.getChild(3).getVertexCount()
      +logo.getChild(4).getVertexCount()+logo.getChild(5).getVertexCount()] = v.copy();
  }
  for (int i = 0; i< logo.getChild(7).getVertexCount(); i++) {
    PVector v = logo.getChild(7).getVertex(i);
    v.x += width/2 - logo.width/2;
    v.y +=  height/2- logo.height/2;
    particlePoses[i+logo.getChild(0).getVertexCount()+logo.getChild(1).getVertexCount()
      +logo.getChild(2).getVertexCount()+logo.getChild(3).getVertexCount()
      +logo.getChild(4).getVertexCount()+logo.getChild(5).getVertexCount()
      +logo.getChild(6).getVertexCount()] = v.copy();
  }
}