import g4p_controls.*; //<>// //<>// //<>// //<>// //<>// //<>//

final color red    = color(255, 0, 0);
final color green  = color(0, 255, 0);
final color blue   = color(0, 0, 255);
final color yellow = color(255, 255, 0);
final color white  = color(255);
final color black  = color(0);

Level_1 l1;
Ball bl;
Bar b;
Database db;
int score;
PImage award;
GTextField nameInput;
GWindow window;
GButton submitName;
GLabel errorLabel;
boolean authenticated;
String username;
GDropList highscores;
boolean ended;

/**
 * @param GEditableTextControl textControl
 * @param GEvent event
 * @return void
 */
//void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
//  if (textControl == nameInput && event == GEvent.CHANGED) {
//    String name = textControl.getText();
//    if (name.length() <= 3 || name.length() >= 10) {
//      println("Username should be at most 10 characters!");
//    } else if (name.length() >= 3) {
//      if (db.userExists(name)) {
//        println("A user already exists by that name!");
//      } else { // add user to Database
//        try {
//          db.addUser(name, 0);
//        } 
//        catch (Exception e) {
//          println(e.getMessage());
//          println(e.toString());
//        }
//      }
//    }
//  }
//}

/**
 * @param GButton button
 * @param GEvent event
 * @return void
 */
void handleButtonEvents(GButton button, GEvent event) {
  errorLabel.setOpaque(true);
  if (button == submitName && event == GEvent.CLICKED) {
    String name = nameInput.getText();
    if (name.length() <= 3 || name.length() >= 10) {
      println("Username should be at most 10 characters!");
      errorLabel.setText("Username should be at most 10 characters!");
    } else {
      if (db.userExists(name)) {
        println("A user already exists by that name!");
        errorLabel.setText("A user already exists by that name!");
      } else { // add user to Database
        errorLabel.setLocalColorScheme(green);
        errorLabel.setText("User '" + name + "' added successfully!");
        username = name;
        try {
          db.addUser(name, 0);
        } 
        catch (Exception e) {
          println(e.getMessage());
          println(e.toString());
        }
      }
    }
  }
}

void createUsernameWindows(PApplet app) {
  println("Making Window");
  GWindow window = GWindow.getWindow(app, "Enter your username", 500, 100, 300, 100, JAVA2D);
  window.addOnCloseHandler(app, "usernameWindowClosing"); 
  window.setActionOnClose(GWindow.CLOSE_WINDOW);

  nameInput = new GTextField(window, 50, 10, 100, 25);
  submitName = new GButton(window, 50, 45, 80, 25, "Submit");
  errorLabel = new GLabel(window, 50, 75, 200, 25, "");
  errorLabel.setLocalColorScheme(red);
}

void createHighscoreWindows(PApplet app) {
  GWindow window = GWindow.getWindow(app, "Highscore Table", 500, 100, 400, 500, JAVA2D);
  window.addOnCloseHandler(app, "highscoreWindowClosing"); 
  window.setActionOnClose(GWindow.CLOSE_WINDOW);

  db.writeHighscores();
  String[] scores = db.getHighscores();
  highscores = new GDropList(window, 200, 110, 200, 100); // x,y,w,h,lSize,bWidth
  highscores.setItems(scores, 0);
}

public void usernameWindowClosing(GWindow w) {
  if (username == null || username.length() == 0) {
    println("Please enter a username!");
    println("Exiting BrickBreaker...");
    exit();
  }
}

public void highscoreWindowClosing(GWindow w) {
  //if () {
  //  println("Please enter a username!");
  //  println("Exiting BrickBreaker...");
  //  exit();
  //}
}

void setup() {
  size(1000, 1000);
  frameRate(30); 

  // change this to be your level for testing
  l1 = new Level_1();

  bl= new Ball();
  b = new Bar();

  award = loadImage("award_512.png");
  db = new Database("highscores.xml");

  createUsernameWindows(this);
  G4P.setCtrlMode(GControlMode.CENTER);
}

void draw() {  
  background(black);
  l1.display();
  bl.display();
  bl.update();
  b.display();
  b.update();

  image(award, 0, 0, 50, 50);
  cursor();

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

  if (checkY && db.authenticated) {
    for (Brick br : l1.bricks) {
      // @TODO: @FIXME: maybe pop destroyed bricks?
      if (!br.destroyed && collided(bl, br)) {
        score += br.TYPE;   
        System.out.println(distance(bl.x, bl.y, br.x, br.y));
        br.destroy();
      }
    }
  }

  if (!ended && score == l1.bricks.size()) {
    ended = true;
    db.writeScore(username, score);
    createHighscoreWindows(this);
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

/**
 * Handle cursor change
 */
void cursor() {
  if (mouseX <= 50 && mouseY <= 50) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}

public static Timestamp getCurrentTimestamp() {
  long time = (new Date()).getTime();
  //println("Time in Milliseconds: " + time);
  return new Timestamp(time);
}
