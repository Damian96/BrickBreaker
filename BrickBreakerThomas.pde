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

  // lastBrick is always rock bottom
  Brick lastBrick = l1.bricks.get(l1.bricks.size()-1);
  Brick firstBrick = l1.bricks.get(0);
  boolean checkY = false;

  if (l1.shape.equals("pyramid")) {
    checkY = bl.y >= (lastBrick.y - Brick.width) && bl.y <= (firstBrick.y + Brick.width);
  } else if (l1.shape.equals("grid")) {
    checkY = bl.y >= (firstBrick.y - Brick.width) && bl.y <= (lastBrick.y + Brick.width);
  } else {
    throw new Error("Please initialize the Level's shape");
  }

  if (checkY) {
    for (Brick br : l1.bricks) {
      if (!br.destroyed && collided(bl, br)) {
        System.out.println(distance(bl.x, bl.y, br.x, br.y));
        br.destroy();
      }
    }
  }
  //System.out.println(l1.bricks.size());
  //System.out.println(firstBrick.toString());
  //System.out.println(lastBrick.toString());
  //System.exit(0);
}

/**
 * @return boolean Whether the specified Brick collided with Ball
 */
boolean collided(Ball ball, Brick brick) {
  return (distance(brick.x, brick.y, ball.x, ball.y) <= (Brick.width/2 + ball.s - 5)) ? true : false;
}

/**
 * Returns the distance between two circles
 */
double distance(int px, int py, int mx, int my) {
  return Math.sqrt((double) Math.pow(px - mx, 2) + Math.pow(py - my, 2));
}
