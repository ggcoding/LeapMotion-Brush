import de.voidplus.leapmotion.*; 
LeapMotion leap; 
ArrayList<PVector> points; 
PVector fp; 
 
void setup() {
  size(800, 500, P3D);
  background(255);
  leap = new LeapMotion(this);
  points = new ArrayList<PVector>(); 
  smooth(20);
  noStroke();
}
 
void draw() {
  background(255);
  int fps = leap.getFrameRate();
  frameRate(fps);
  for (Hand hand : leap.getHands()) {
    for (Finger finger : hand.getFingers()) {
      fp   = finger.getPosition(); 
 
      if (fp.z <= 30) {
        fill(0);
        ellipse(fp.x, fp.y, constrain(fp.z, 10, 20), constrain(fp.z, 10, 20));
      }
      else if (fp.z > 0) {
        points.add(new PVector(fp.x, fp.y));
      }
    }
  }
  for (int i = points.size()-1; i >= 0; i--) {
    PVector p = points.get(i);
    fill(23, 77, 255);
    ellipse(p.x, p.y, 10, 10);
  }
}
 
void keyPressed() {
  if (key == 32) {
    points = new ArrayList<PVector>();
  }
}
