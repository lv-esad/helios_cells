class Croisement{
  
  Position p1;
  Position p2;
  
  Croisement(Position position1, Position position2){
    p1 = position1;
    p2 = position2;
  }
  
  public JSONArray getJSON(){
    JSONArray json = new JSONArray();
    json.setJSONObject(0,p1.getJSON());
    json.setJSONObject(1,p2.getJSON());
    return json;
  }
}
