JSONObject json;
JSONArray values;


void setup ()
{
  size(800, 600, P3D);
  background(255);
  camera(500, 100,100,500,100, 00, 0, 0, 01);
  
  json = loadJSONObject("croisementsSomme.json"); 

  noFill();
  smooth();
  
     int i =0;
JSONArray jsonCroisementsSomme = loadJSONArray("croisementsSomme.json"); 
    for (i=0; i<jsonCroisementsSomme.size (); i++) {

      JSONObject jsonCroisementSomme = jsonCroisementsSomme.getJSONObject(i);
      float x = float(jsonCroisementSomme.getInt("x")); // convert int to String
      float y = float(jsonCroisementSomme.getInt("y")); // convert int to String
      float iteration = float(jsonCroisementSomme.getInt("i")); // convert int to String
      String msg = x+";"+y+";"+iteration;
      
      point(x,y,iteration);
   println(msg);


  } 
  
}

