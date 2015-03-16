
class Croisement{
  
  Position p1;
  Position p2;
  int x;
  int y;
  boolean dejaSomme = false;
  
  Croisement(Position position1, Position position2){
    p1 = position1;
    p2 = position2;
    x = p1.x;
    y = p1.y;

  }
  
  public JSONArray getJSON(){
    JSONArray json = new JSONArray();
    json.setJSONObject(0,p1.getJSON());
    json.setJSONObject(1,p2.getJSON());
    return json;
  }

 
}

class CroisementSomme{
  int x;
  int y;
  int count;
  ArrayList<Croisement> croisements = new ArrayList<Croisement>();
  CroisementSomme(Croisement c){
    x = c.x;
    y = c.y;
    this.add(c);
  }
  void add(Croisement c){
    croisements.add(c);
    c.dejaSomme = true;
    //println("add ",x,y,croisements.size());
  }

  
  JSONObject getJSON(){
    
    JSONObject json = new JSONObject();
    json.setInt("x",x);
    json.setInt("y",y);
    json.setInt("i",croisements.size());
    
    return json;
    
  }
  }

