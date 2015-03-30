JSONArray jsonCroisementsSomme;
PImage masque;

void setupViewer () {
  size(GRID_SIZE*GRID_X+1, GRID_SIZE*GRID_Y+1, P3D);
  jsonCroisementsSomme = loadJSONArray("positionsSomme.json");
  masque = loadImage("plan4.png");
}

int PositionIteration(int x1, int y1) {
  
  for (int i=0; i<jsonCroisementsSomme.size (); i++) {
    JSONObject jsonCroisementSomme = jsonCroisementsSomme.getJSONObject(i);
    float x = float(jsonCroisementSomme.getInt("x")); // convert int to String
    float y = float(jsonCroisementSomme.getInt("y")); // convert int to String
    int z = int(jsonCroisementSomme.getInt("z")); // convert int to String
  //  int iteration = int(jsonCroisementSomme.getInt("i")); // convert int to String
    
    
  /*  int hauteur;
    hauteur = iteration<2?1: iteration<5?2: iteration<9?3: iteration<15?4:5;*/
   // println(hauteur);
    
    
    if ((x1 == x) && (y1==y)) {
     // println(x1,y1,x,y);
      return z;
    }
    
  }
  return 0;
}
//création du masque pour n'afficher que les cubes qui sont dans le batiment
 Boolean isNotMask (int x, int y) {
 color pixel = masque.get(x,y);
int i = pixel;
 return i== 0;
 }


  void drawViewer () {
    
     
           if (keyPressed) {
    switch(key) {
              case 'p' :
      // copie l'ecran dans un fichier
      int d = day();    
      int m = month();  
      int y = year();     
      int h = hour();  
      int min = minute();  
      saveFrame("Phase-de--rencontre//Helios-rencontre" + d + "-" + m + "-" + y + "-" + "à" + "-" + h + "h"+ min + "min" + ".jpg");
      break;
      
    }
  }
    background(255);
    
    randomSeed(10);
    camera    (GRID_SIZE*GRID_X/2, 0, -400, 
    GRID_SIZE*GRID_X/2, GRID_SIZE*GRID_Y/2, 0, 
    0.0, 1, 1.0);
    for (int i=0; i<=GRID_X; i++) {
      for (int j=0; j<=GRID_Y; j++) {
        if (isNotMask (i,j)) {
        for(int z=0; z<=5; z++) {
        for  (int Niveau=0 ; Niveau<4-PositionIteration(i, j); Niveau++) {

          pushMatrix();
          translate(i*GRID_SIZE, j*GRID_SIZE, -Niveau*GRID_SIZE);
          box(GRID_SIZE);
          popMatrix();
          

      
      
          
        }
      }
        }
      }
    }
  }

