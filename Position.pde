class Position {
  
  int x;
  int y;
  int date;
  int user;

  color couleur;
  color invertColor;
  
  boolean dejaCroise = false;
  
  Position(int xGrid, int yGrid, color c, int i, int d){
    x = xGrid;
    y = yGrid;
    couleur = c;
    user = i;
    date = d;
    invertColor = color(255-red(c),255-green(c),255-blue(c));
  }
  
  public boolean match(Position testPosition){
    return  x == testPosition.x && y == testPosition.y;
    
  }
  public JSONObject getJSON(){
    JSONObject json = new JSONObject();
    json.setInt("x",x);
    json.setInt("y",y);
    json.setInt("date",date);
    json.setInt("user",user);
    json.setInt("color",couleur);
    return json;
  }
}
