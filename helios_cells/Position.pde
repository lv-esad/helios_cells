class Position {
  
  int x;
  int y;
  int date;
  int user;

  color couleur;
  
  Position(int xGrid, int yGrid, color c, int i, int d){
    x = xGrid;
    y = yGrid;
    couleur = c;
    user = i;
    date = d;
  }
}
