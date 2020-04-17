import de.voidplus.leapmotion.*;
//import java.io.FilenameFilter;
import processing.sound.*;
import java.awt.Rectangle;
import java.io.FilenameFilter;
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
ArrayList<SoundFile> soundfiles = new ArrayList<SoundFile>();
String[] soundNames;

LeapMotion leap;

void setup() {
  size(1220, 500, P3D);
  //frameRate(200);
  index = 20;
  // Create an empty ArrayList (will store Ball objects)
  flowers = new ArrayList<Flower>();
  
  // Start by adding one element
  flowers.add(new Flower(width/2, 0, flowerWidth));
  leap = new LeapMotion(this);
  textAlign(CENTER);
  smooth(20);
  String path = sketchPath("data/audio");
  soundNames = listFileNames(path);
  printArray(soundNames);
  
  for (int i = 0; i < soundNames.length; i ++){
     soundfiles.add(new SoundFile(this, "audio/"+soundNames[i])); 
  }
  

  
}

void draw(){  
   if (leap.isConnected() == false){
    println("Can't connect to LeapMotion, maybe leapMotion is not connected!"); 
    stop();
    //return; 
  }
  //noCursor();
  int fps = leap.getFrameRate();
  frameRate(fps);
  fill(#00E310);
  text(fps + " fps", 20, 20);

  for (Hand hand : leap.getHands()) {
    if (hand.isLeft()){
    PVector left_thumbTip = hand.getThumb().getRawPositionOfJointTip();
    PVector left_indexTip = hand.getIndexFinger().getRawPositionOfJointTip();
    PVector left_middleTip = hand.getRingFinger().getRawPositionOfJointTip();
    PVector left_ringTip = hand.getMiddleFinger().getRawPositionOfJointTip();
    PVector left_pinkyTip = hand.getPinkyFinger().getRawPositionOfJointTip();

    handleFinger(left_thumbTip, "left_thb");
    handleFinger(left_indexTip, "left_idx");
    handleFinger(left_middleTip, "left_mdl");
    handleFinger(left_ringTip, "left_rng");
    handleFinger(left_pinkyTip, "left_pky");
    }else{
      if (hand.isRight()){
    PVector right_thumbTip = hand.getThumb().getRawPositionOfJointTip();
    PVector right_indexTip = hand.getIndexFinger().getRawPositionOfJointTip();
    PVector right_middleTip = hand.getRingFinger().getRawPositionOfJointTip();
    PVector right_ringTip = hand.getMiddleFinger().getRawPositionOfJointTip();
    PVector right_pinkyTip = hand.getPinkyFinger().getRawPositionOfJointTip();

    handleFinger(right_thumbTip, "right_thb");
    handleFinger(right_indexTip, "right_idx");
    handleFinger(right_middleTip, "right_mdl");
    handleFinger(right_ringTip, "right_rng");
    handleFinger(right_pinkyTip, "right_pky");
    }
   }//hand.draw();
  }
 String txt_fps = String.format(getClass().getName()+ " [fps %6.2f]", frameRate);
 surface.setTitle(txt_fps);  
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
  if(id == "left_thb"){
    if(!soundfiles.get(0).isPlaying()){
       soundfiles.get(0).play(); 
        println("trigger the soundfile :"+soundNames[0]); 
     }   
  }
  if(id == "left_idx"){
    if(!soundfiles.get(1).isPlaying()){
       soundfiles.get(1).play(); 
        println("trigger the soundfile :"+soundNames[1]); 
     }   
  }
  if(id == "left_mdl"){
    if(!soundfiles.get(2).isPlaying()){
       soundfiles.get(2).play(); 
        println("trigger the soundfile :"+soundNames[2]); 
     }   
  }
  if(id == "left_rng"){
    if(!soundfiles.get(3).isPlaying()){
       soundfiles.get(3).play(); 
        println("trigger the soundfile :"+soundNames[3]); 
     }   
  }
   if(id == "left_pky"){
    if(!soundfiles.get(4).isPlaying()){
       soundfiles.get(4).play(); 
        println("trigger the soundfile :"+soundNames[4]); 
     }   
  }
 if(id == "right_thb"){
    if(!soundfiles.get(5).isPlaying()){
       soundfiles.get(5).play(); 
        println("trigger the soundfile :"+soundNames[5]); 
     }   
  }
  if(id == "right_idx"){
    if(!soundfiles.get(6).isPlaying()){
       soundfiles.get(6).play(); 
        println("trigger the soundfile :"+soundNames[6]); 
     }   
  }
  if(id == "right_mdl"){
    if(!soundfiles.get(7).isPlaying()){
       soundfiles.get(7).play(); 
        println("trigger the soundfile :"+soundNames[7]); 
     }   
  }
  if(id == "right_rng"){
    if(!soundfiles.get(8).isPlaying()){
       soundfiles.get(8).play(); 
        println("trigger the soundfile :"+soundNames[8]); 
     }   
  }
   if(id == "right_pky"){
    if(!soundfiles.get(9).isPlaying()){
       soundfiles.get(9).play(); 
        println("trigger the soundfile :"+soundNames[9]); 
     }   
  }
  //fill(255); // label
  //text(id, x+ 30, y);
}

void mousePressed() {
 flowers.add(new Flower(mouseX, mouseY, flowerWidth));
  
}


FilenameFilter soundFileFilter = new FilenameFilter(){
  public boolean accept(File dir, String name) {
    String lowercaseName = name.toLowerCase();
    return (!lowercaseName.startsWith(".")&& lowercaseName.endsWith(".wav") || !lowercaseName.startsWith(".")&& lowercaseName.endsWith(".aif") || !lowercaseName.startsWith(".")&& lowercaseName.endsWith(".mp3"));
  }
};
    
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  // See: https://docs.oracle.com/javase/6/docs/api/java/io/File.html
  
  if (file.isDirectory()) {
    
    String names[] = file.list(soundFileFilter);
    printArray(names);
    return names;
    
  } else {
    // If it's not a directory
    return null;
  }
}
