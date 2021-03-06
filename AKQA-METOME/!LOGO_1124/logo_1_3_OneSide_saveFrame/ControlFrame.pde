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
       .setValue(1.0)
       .setPosition(10, 10)
       .setSize(300, 30);
       
       
  }

  void draw() {
    background(190);
  }
}