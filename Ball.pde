//this class represents the ball bounce speed angles rotation etc
class Ball {
  int x, y, z; //coordinates
  int s; //size of ellipse

  Ball() {
    x = 100;
    y = 100;
    s=20;
  }

  void display() { 
    //pushMatrix();
    //translate(x, y);
    fill(random(255), random(255), random(255));
    circle(x, y, s);
    //noStroke();     
    //popMatrix();
  }  

  public void update() {
    //TODO if it collides change dir
    int dir = 2*((int)random(2)) -1;    

    //x+=1*dir;
    //y+=1*dir;

    x=mouseX;
    y=mouseY;
  }

  public String toString() {
    return "Ball[x:" + this.x + ",y:" + this.y + ",s:" + this.s + "]";
  }
}
