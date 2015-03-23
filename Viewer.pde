JSONArray jsonCroisementsSomme;

void setupViewer () {
  size(GRID_SIZE*GRID_X+1, GRID_SIZE*GRID_Y+1, P3D);
  jsonCroisementsSomme = loadJSONArray("croisementsSomme.json");
}

int PositionIteration(int x1, int y1) {
  
  for (int i=0; i<jsonCroisementsSomme.size (); i++) {
    JSONObject jsonCroisementSomme = jsonCroisementsSomme.getJSONObject(i);
    float x = float(jsonCroisementSomme.getInt("x")); // convert int to String
    float y = float(jsonCroisementSomme.getInt("y")); // convert int to String
    int iteration = int(jsonCroisementSomme.getInt("i")); // convert int to String
    int hauteur;
    hauteur = iteration<2?1: iteration<5?2: iteration<9?3: iteration<15?4:5;
   // println(hauteur);
    
    
    if ((x1 == x) && (y1==y)) {
     // println(x1,y1,x,y);
      return iteration;
    }
    
  }
  return 0;
}


  void drawViewer () {
    background(255);
    randomSeed(10);
    camera    (GRID_SIZE*GRID_X/2, 0, 800, 
    GRID_SIZE*GRID_X/2, GRID_SIZE*GRID_Y/2, 0, 
    0.0, 1, 1.0);
    for (int i=0; i<=GRID_X; i++) {
      for (int j=0; j<=GRID_Y; j++) {
        for(int z=0; z<=5; z++) {
        for  (int Niveau=0 ; Niveau<PositionIteration(i, j); Niveau++) { //random(1,4)/*-

          pushMatrix();
          translate(i*GRID_SIZE, j*GRID_SIZE, Niveau*GRID_SIZE);
          box(GRID_SIZE);
          popMatrix();
        }
        }
      }
    }

  /*  noFill();
    smooth();
    camera    (GRID_SIZE*GRID_X/2, 0, 400, 
    GRID_SIZE*GRID_X/2, GRID_SIZE*GRID_Y/2, 0, 
    0.0, 1, 1.0);
    int i =0;

    for (i=0; i<jsonCroisementsSomme.size (); i++) {

      JSONObject jsonCroisementSomme = jsonCroisementsSomme.getJSONObject(i);
      float x = float(jsonCroisementSomme.getInt("x")); // convert int to String
      float y = float(jsonCroisementSomme.getInt("y")); // convert int to String
      float iteration = float(jsonCroisementSomme.getInt("i")); // convert int to String
      String msg = x+";"+y+";"+iteration;
      pushMatrix();
      translate(x*GRID_SIZE, y*GRID_SIZE, iteration);
      box(2, 2, 2);
      popMatrix();
      println(msg);
    }
    
*/  }

