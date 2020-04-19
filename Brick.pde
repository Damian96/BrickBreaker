// Brick types constants
final int BRICK_NORMAL = 1; // wooden
final int BRICK_SOLID = 2; // rock
final int BRICK_STEEL = 3; // steel

class Brick {
  public final static int width = 25;
  public final static int height = 25;
  private color fill = white;

  protected int TYPE = BRICK_NORMAL;

  private boolean destroyed = false;
  protected int startX = 500;
  protected int startY = 200;

  protected int x;
  protected int y;

  Brick() {
    TYPE = BRICK_NORMAL;
    fill = white;
  }

  Brick(int t, color f) {
    this.TYPE = t;
    this.fill = f;
  }

  /**
   * Display brick on starting position
   */
  public void display() {
    if (destroyed) {
      noFill();
      noStroke();
    } else {
      fill(fill);
      stroke(black);
    }
    this.x =startX-width/2;
    this.y = startY-height/2;
    rect(startX-width/2, startY-height/2, width, height);
  }

  /**
   * Draws a rectangle in the position (startX-width/2-g, startY-height/2-h)
   * @param {integer} g The gap of x (negative -> to the left)
   * @param {integer} h The gap of y (negative -> to the top)
   */
  // public void display(int g, int h) {
  //   if (destroyed) {
  //     noFill();
  //     noStroke();
  //   } else {
  //     fill(fill);
  //     stroke(black);
  //   }
  //   rect(startX-width/2-g, startY-height/2-h, width, height);
  // }

  /**
   * Draws a rectangle in the position (x, y)
   * @param {integer} x The position x
   * @param {integer} y The position y
   */
  public void display(int x, int y) {
    if (destroyed) {
      noFill();
      noStroke();
    } else {
      fill(fill);
      stroke(black);
    }
    this.x = x;
    this.y = y;
    rect(x, y, width, height);
  }  

  public void update() {
  }

  public void destroy() {
    noFill();
    noStroke();
    rect(x, y, width, height);
    rect(x, y, width, height);
    destroyed = true;
  }

  public String toString() {
    return "Brick[x:" + this.x + ",y:" + this.y + ",width:" + Brick.width + ",destroyed:" + this.destroyed + ",type:" + this.TYPE + ",fill:" + this.fill + "]";
  }
}
