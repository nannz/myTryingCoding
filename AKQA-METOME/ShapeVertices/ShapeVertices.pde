/**
 * Shape Vertices. 
 * 
 * How to iterate over the vertices of a shape.
 * When loading an obj or SVG, getVertexCount() 
 * will typically return 0 since all the vertices 
 * are in the child shapes. 
 *
 * You should iterate through the children and then
 * iterate through their vertices.
 */

// The shape
PShape logo;

void setup() {
  size(640, 360);
  // Load the shape
  logo = loadShape("logo.svg");
  println(logo.getChildCount());
}

void draw() {
  background(255,5);
  // Center where we will draw all the vertices
  translate(width/2 - logo.width/2, height/2- logo.height/2);
  
  // Iterate over the children
  int children = logo.getChildCount();
  for (int i = 0; i < children; i++) {
    PShape child = logo.getChild(i);
    int total = child.getVertexCount();
    
    // Now we can actually get the vertices from each child
    for (int j = 0; j < total; j++) {
      PVector v = child.getVertex(j);
      // Cycling brightness for each vertex
      stroke(255-(frameCount + (i+1)*j) % 255);
      // Just a dot for each one
      point(v.x, v.y);
    }
  }
}