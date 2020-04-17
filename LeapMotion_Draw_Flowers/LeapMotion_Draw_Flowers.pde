import de.voidplus.leapmotion.*;
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;
import processing.core.*;
import processing.opengl.PGraphics2D;

float INTERACTION_SPACE_WIDTH = 200; // left-right from user
float INTERACTION_SPACE_DEPTH = 150; // away-and-toward user
float INTERACTION_SPACE_HEIGHT = 300; //up and down
float FINGER_DOT = 30;
ArrayList<Flower> flowers;
int flowerWidth = 48;
Flower flower;
int index;
float my_x;
float my_y;

LeapMotion leap;

void setup() {
  size(1920, 500, P3D);
  frameRate(120);
  index = 50;
  // Create an empty ArrayList (will store Ball objects)
  flowers = new ArrayList<Flower>();
  
  // Start by adding one element
  flowers.add(new Flower(width/2, 0, flowerWidth));
  leap = new LeapMotion(this);
  textAlign(CENTER);

  
}

void draw(){  
  // FPS
  //noCursor();
  int fps = leap.getFrameRate();
  fill(#00E310);
  text(fps + " fps", 20, 20);

  for (Hand hand : leap.getHands ()) {

    PVector thumbTip = hand.getThumb().getRawPositionOfJointTip();
    PVector indexTip = hand.getIndexFinger().getRawPositionOfJointTip();
    PVector ringTip = hand.getRingFinger().getRawPositionOfJointTip();
    PVector middleTip = hand.getMiddleFinger().getRawPositionOfJointTip();
    PVector pinkyTip = hand.getPinkyFinger().getRawPositionOfJointTip();

    handleFinger(thumbTip, "thb");
    handleFinger(indexTip, "idx");
    handleFinger(middleTip, "mdl");
    handleFinger(ringTip, "rng");
    handleFinger(pinkyTip, "pky");

    //hand.draw();
  }
 //String txt_fps = String.format(getClass().getName()+ "[size %d/%d]   [frame %d]   [fps %6.2f]", frameRate);
 //surface.setTitle(txt_fps);  
}

void handleFinger(PVector pos, String id) {

  // map finger tip position to 2D surface
  float x = map(pos.x, -INTERACTION_SPACE_WIDTH, INTERACTION_SPACE_WIDTH, 0, width);
  float y = map(pos.z, -INTERACTION_SPACE_DEPTH, INTERACTION_SPACE_DEPTH, 0, height);
  float z = pos.y;
  //println(z);
  //fill(#00E310);
  //noStroke();
  //ellipse(x, y, FINGER_DOT, FINGER_DOT);
  index --;
  if (index < 0){
      flowers.add(new Flower(my_x, my_y, flowerWidth)); 
      index = 500;
   }
  
   //println("hello");
    for (int i = flowers.size()-1; i >= 0; i--) { 
      flower = flowers.get(i);// An ArrayList doesn't know what it is storing so we have to cast the object coming out
      flower.move(x, y);
      flower.display(z);
        if (flower.finished()) {  // Items can be deleted with remove()

        flowers.remove(i);
    }
  }
  //fill(255); // label
  //text(id, x+ 30, y);
}

void mousePressed() {
 flowers.add(new Flower(mouseX, mouseY, flowerWidth));
  
}
