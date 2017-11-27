class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);   
       
    cp5.addSlider("Size of Particle")
       .plugTo(parent, "rad")
       .setRange(0, 5.0)
       .setValue(3.0)
       .setPosition(10, 70)
       .setSize(300, 30);
    cp5.addSlider("Extent of twist")
      .plugTo(parent, "flowMag")
      .setRange(0.0, 0.1)
      .setValue(0.05)
      .setPosition(10,110)
      .setSize(300,30);    
    cp5.addSlider("direction")
      .plugTo(parent, "flowAngle")
      .setRange(0.0, 4 * PI)
      .setValue(TWO_PI)
      .setPosition(10, 150)
      .setSize(300,30);
      
    cp5.addToggle("show Logo")
      .plugTo(parent,"showLogo")
      .setPosition(10, 10)
      .setSize(40,40)
      .setValue(true);
  }

  void draw() {
    background(190);
  }
}