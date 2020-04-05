//import  //<>//

class Level_1 { 
  ArrayList<Brick> bricks;

  // start coordinates of Bricks
  // negative is far left -> positive is far right
  protected int startX = 520-5*Brick.width;
  // negative is top -> positive is bottom
  protected int startY = 450;

  protected String shape;

  Level_1() {
    // @TODO: @FIXME:
    // REMEBER TO CHANGE SIZE TO:
    // 25 FOR GRID()
    // 15 FOR PYRAMID()
    bricks = new ArrayList<Brick>(25);    
    for (int i = 0; i < 25; i++) {
      bricks.add(new Brick());
    }
  }

  void display() {    
    fill(white);
    ellipse(500, 500, 1000, 1000);
    stroke(red);
    grid();
    shape = "grid";
    //pyramid();
    //shape = "pyramid";
  }

  // 3x5 grid
  public void grid() {
    int rows = 5;
    //startX -= rows*Brick.width;
    Brick br;
    int cols = 5;
    int gap = 5; // both x, y
    for (int r = 0; r < rows; r++) { // rows
      int i;
      for (int c = 0; c < cols; c++) { // columns
        if (r > 0 && c > 0)
          i=r*rows+c;
        else if (r == 0 && c > 0) // firt row, * column
          i=c;
        else if (r > 0 && c == 0) // first column, * row
          i=r*rows;
        else // 0
        i = 0;

        br = bricks.get(i);
        if (!br.destroyed) {
          br.display((startX+Brick.width/2)+(c*Brick.width)+(c*gap), (startY+Brick.height/2)+(r*Brick.height)+(r*gap));
        }
      }
    }
  }

  // 5-based pyramid
  public void pyramid() {
    int rows = 5;
    // delete extra bricks
    //startX -= rows*Brick.width;
    Brick br;
    int sX = startX; // startX for local use
    int gapX = Brick.width-10; // x
    int gapY = 5; // y
    int i = 0;
    for (int r=0; r < rows; r++) {
      sX += gapX+5;
      for (int c=0; c < (rows-r); c++) {
        br = bricks.get(i);
        br.display((sX+Brick.width/2)+(c*Brick.width)+(c*gapX), (startY-Brick.height/2)-(r*Brick.height)-(r*gapY));
        i++;
      }
    }
  }

  /**
   * @return int
   */
  public int sumDigits(int i) {
    return i == 0 ? 0 : i + sumDigits(i-1);
  }
}
