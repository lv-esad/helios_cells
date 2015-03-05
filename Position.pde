class Position{
  
  int x;
  int y;
  int date;
  int user;

  color couleur;
  color invertColor;
  
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
}
