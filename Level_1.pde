class Level_1 { 
  final static int startX = 520-25*5;
  final static int startY = 450;
  ArrayList<Brick> bricks;

  Level_1() {    
    // start coordinates of Bricks    
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
  }

  // 3x5 grid
  public void grid() {
    Brick br;
    int rows = 5;
    int cols = 5;
    int gap = 5;
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
}
