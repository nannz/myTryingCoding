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
    cp5.addToggle("show Logo")
      .plugTo(parent, "showLogo")
      .setPosition(10, 10)
      .setSize(40, 40)
      .setValue(true);
    cp5.addToggle("start Recoding")
      .plugTo(parent, "recording")
      .setPosition(60, 10)
      .setSize(40, 40)
      .setValue(false);


    cp5.addSlider("Size of Particle")
      .plugTo(parent, "rad")
      .setRange(0, 5.0)
      .setValue(2.5)
      .setPosition(10, 70)
      .setSize(300, 18);
    
    cp5.addSlider("Max Speed of Particle")
      .plugTo(parent, "maxVel")
      .setRange(0, 5.0)
      .setValue(1.0)
      .setPosition(10, 95)
      .setSize(300, 18);
    

    cp5.addToggle("apply Wind")
      .plugTo(parent, "applyWind")
      .setValue(true)
      .setPosition(10, 140)
      .setSize(20, 20);
    cp5.addSlider("Wind Strength")
      .plugTo(parent, "windMag")
      .setRange(0.0, 0.5)
      .setValue(0.03)
      .setPosition(10, 170)
      .setSize(150, 10);
    cp5.addSlider("Wind Center X")
      .plugTo(parent, "windCenterX")
      .setRange(0.0, 1680.0)
      .setPosition(30, 190)
      .setSize(100, 10)
      .setValue(840);   
    cp5.addSlider("Wind Center Y")
      .plugTo(parent, "windCenterY")
      .setRange(0.0, 1050.0)
      .setPosition(10, 190)
      .setSize(10, 100)
      .setValue(525.0);
      
      cp5.addToggle("apply FlowField")
      .plugTo(parent, "applyFlowField")
      .setValue(true)
      .setSize(25,25)
      .setPosition(10,330);
     //this version only apply wind, no flow field
     cp5.addSlider("Extent of twist")
     .plugTo(parent, "flowMag")
     .setRange(0.0, 0.1)
     .setValue(0.05)
     .setPosition(10,380)
     .setSize(300,10);    
     cp5.addSlider("direction")
     .plugTo(parent, "flowAngle")
     .setRange(0.0, 4 * PI)
     .setValue(TWO_PI)
     .setPosition(10, 405)
     .setSize(300,10);
     
  }

  void draw() {
    background(190);
  }
}