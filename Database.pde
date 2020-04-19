import java.util.Date; //<>// //<>// //<>// //<>// //<>//
import java.sql.Timestamp;
import javax.xml.transform.stream.StreamResult;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import java.util.Arrays;
import org.w3c.dom.*;

public class Database {
  String file = "highscores.xml";
  XML xml;
  XML[] users;
  int registered;
  boolean authenticated;
  String[] scoreList;

  Database (String f) {
    file = f;
    setup();
  }

  void setup() {
    xml = loadXML(file);
    //users = xml.getChild(0).getChildren("user");
    users = xml.getChildren("user");
    scoreList = new String[users.length];
  }

  void save() {
    XML user;
    for (int i=users.length-registered; i<users.length; i++) {
      user = users[i];
      if (!user.getString("username").equals(null)) xml.addChild(user);
    }

    saveXML(xml, file);
  }

  /**
   * @param String username
   * @return boolean
   */
  boolean userExists(String username) {
    for (XML user : users) { 
      if (user.getString("username").equals(username)) return true;
    }
    return false;
  }

  /**
   * @param String username
   * @param int score If score is greater than 0, add it to the database
   * @throws Exception
   */
  void addUser(String username, int score) throws Exception {
    if (userExists(username)) {
      throw new Exception("User: " + username + " already exists!");
    }

    XML user = new XML("user");
    user.setString("username", username);
    user.setString("created", String.valueOf(getCurrentTimestamp().getTime()));
    if (score > 0) user.setInt("score", score);
    users = (XML[]) append(users, user);
    registered++;
    authenticated = true;
    save();
    writeHighscores();
  }

  /**
   * @return void
   */
  void writeScore(String username, int score) {
    for (XML user : users) {   
      if (user.getString("username").equals(username)) {
        user.setInt("score", score);
      }
    }
    save();
    writeHighscores();
  }

  /**
   * @return void
   */
  void writeHighscores() {
    String[] scores = new String[users.length];
    for (XML user : users) {
      scores = append(scores, (user.getString("username") + "," + user.getString("score") + "," + user.getString("created")));
      scoreList = append(scoreList, ("Username: " + user.getString("username") + ", Score: " + user.getString("score")));
    }
    saveStrings("highscores.txt", scores);
  }

  /**
   *
   */
  String[] getHighscores() {
    return scoreList;
  }
}
