// Simple bouncing ball class

class Flower {
  
  float x;
  float y;
  float speed;
  int angle;
  float gravity;
  float w;
  float life = 512;
  
  Flower(float tempX, float tempY, float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    angle = 0;
    gravity = 0.1;
  }
  
    void move(float my_x, float my_y) {
      x = my_x;
      y = my_y;
  }
  
  boolean finished() {
    // flower fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void display (float z) {
    // Display the flower
    fill(255, 1); // over writing screen on display() call
  //noStroke();
    rect(0, 0, width, height);
    angle += 1;
    float val = cos(radians(angle)) *z/10;
    for (int a = 0; a < 360; a += 75) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(0, life);
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(255, life);
    ellipse(x, y, 2, 2);
  }
}
