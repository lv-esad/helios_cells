class Position {

  int x;
  int y;
  int date;
  int user;

  color couleur;
  color invertColor;

  boolean dejaCroise = false;
  boolean dejaAdditionne = false;

  Position(int xGrid, int yGrid, color c, int i, int d) {
    x = xGrid;
    y = yGrid;
    couleur = c;
    user = i;
    date = d;
    invertColor = color(255-red(c), 255-green(c), 255-blue(c));
  }

  public boolean match(Position testPosition) {
    return  x == testPosition.x && y == testPosition.y;
  }
  public JSONObject getJSON() {
    JSONObject json = new JSONObject();
    json.setInt("x", x);
    json.setInt("y", y);
    json.setInt("date", date);
    json.setInt("user", user);
    json.setInt("color", couleur);
    return json;
  }
}


class PositionSomme {
  int x=0;
  int y=0;
  ArrayList<Position> positions = new ArrayList<Position> ();


  PositionSomme (Position p) {  
    positions.add(p);
    x=p.x;
    y=p.y;
  }
  Boolean userExist(Position p) {
    for (Position pTest : positions) {
      if (p.user==pTest.user) {
        return true;
      }
    }
    return false;
  }
  void ajoutePosition(Position p) {
    positions.add(p);
  }

  JSONObject getJSON() {

    JSONObject json = new JSONObject();
    json.setInt("x", x);
    json.setInt("y", y);
    json.setInt("z", positions.size());
    return json;
  }
}

