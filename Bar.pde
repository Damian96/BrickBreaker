class Bar {
  float x, y, z; //location of the ellipse
  float rot=0;
  // I like to use variables, make easier to change / adapt
  int centerX = 500;
  int centerY = 500;

  // Location of moving circle to start with (stationary)
  int circleX = centerX;  
  int circleY = centerY - 9;

  int diskW = 1010;
  int diskH = 1010;
  float pos = 0;
  float angle;

  Bar() {    
    x = 500;
    y = 500;
  } 

  void display() { 
    angle = atan2(y, x);     
    pushMatrix();
    translate(x, y);
    fill(red);
    rotate(1.77);
    rotate(rot);       
    rect(-30, 0, 15, 200);       
    popMatrix();
  }

  //the higher the speed the higher the rot
  void update() {  
    if (keyCode == LEFT) {      
      pos += 0.1;
      rot -= TWO_PI/62.9;
    }
    if (keyCode == RIGHT) {
      pos -= 0.1;
      rot += TWO_PI/62.9;
    }
    //keeps it circlical movment
    x = int(centerX + 0.5 * diskW * sin(pos));
    y = int(centerY + 0.5 * diskH * cos(pos));
  }
}
