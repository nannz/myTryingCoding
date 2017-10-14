class Walker {
  PVector location;
  PVector direction = new PVector(0, 0, 0);
  float r;
  float bouncing;

  Walker(PVector location, float r, PVector direction) {
    this.location = location;
    this.r = r;
    this.direction = direction;
  }
  Walker(PVector location, float r, PVector direction, float bouncing) {
    this.location = location;
    this.r = r;
    this.direction = direction;
    this.bouncing = bouncing;
  }

  void drawWalker() {
    noStroke();
    lights();
    fill(148);
    translate(location.x, location.y, location.z);
    sphere(r);
  }

  void updateLocation() {
    if (((location.y+r) > width-bouncing) || ((location.y-r)<bouncing)) {
      println("yo");
      direction.y = direction.y*-1;
    } 
    if (((location.x+r)> height-bouncing)||((location.x-r)<bouncing)) {
      direction.x = direction.x*-1;
    }
    if (((location.z+r)> height-bouncing)||((location.z-r)<bouncing)) {
      direction.z = direction.z*-1;
    }
    location.add(direction);
  }

  void drawBouncing() {
    pushMatrix();
    translate(width/2, height/2,height/2);
    strokeWeight(1); 
    stroke(0); 
    noFill();
    box(bouncing);  //
    popMatrix();
  }
}