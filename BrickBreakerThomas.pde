//  //<>//
// 04-03 | Damianos: Added collision detection, Brick.destroy function, Level_1.grid function
//
//
//
//
//
//
//
//
//
//

final color red    = color(255, 0, 0); //<>// //<>//
final color blue   = color(0, 0, 255);
final color yellow = color(255, 255, 0);
final color white  = color(255);
final color black  = color(0);

Level_1 l1;
Ball bl;
Bar b;

void setup() {
  size(1000, 1000);
  frameRate(30); 

  // change this to be your level for testing
  l1 = new Level_1();

  bl= new Ball();
  b = new Bar();
}

void draw() {  
  background(black);
  l1.display();
  bl.display();
  bl.update();
  b.display();
  b.update();

  Brick lastBrick = l1.bricks.get(l1.bricks.size()-1);
  if (bl.y <= (lastBrick.y+lastBrick.height)) {
    for (Brick br : l1.bricks) {
      //System.out.println(bl.toString());
      //System.out.println(br.toString());
      //System.out.println((bl.x >= br.x && bl.x <= (bl.x+br.width)));
      //System.out.println(collisionDetection(bl, br));
      if (!br.destroyed && collided(bl, br)) {
        System.out.println(distance(bl.x, bl.y, br.x, br.y));
        br.destroy();
      }
    }
  }
}

/**
 * @return boolean Whether the specified Brick collided with Ball
 */
boolean collided(Ball ball, Brick brick) {
  return (distance(brick.x, brick.y, ball.x, ball.y) <= (brick.width/2 + ball.s - 10)) ? true : false;
}

/**
 * Returns the distance between two circles
 */
double distance(int px, int py, int mx, int my) {
  return Math.sqrt((double) Math.pow(px - mx, 2) + Math.pow(py - my, 2));
}
