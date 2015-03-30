
color randomColor;
int userIndex = 0;

int lastInputTime = 0;
int inputFrenquency = 100;

PImage plan;

ArrayList<Position> positions = new ArrayList<Position>();
ArrayList<Croisement> croisements = new ArrayList<Croisement>();
ArrayList<CroisementSomme> croisementsSomme = new ArrayList<CroisementSomme>();
ArrayList<PositionSomme> positionsSomme = new ArrayList<PositionSomme>();

void setupEditor() {
  plan = loadImage("plan.png");
  GRID_Y = GRID_X*plan.height/plan.width;
  size(GRID_SIZE*GRID_X+1, GRID_SIZE*GRID_Y+1);
}

void mousePressedEditor() {
  randomColor = color(random(128)+128, random(128)+128, random(128)+128);
  userIndex ++;
}

void drawEditor() {

  boolean displayColor = true;
  // dessine la grille
  background(255);

  image(plan, 0, 0, width, height);
 // image(loadImage("plan3.png"), 0, 0);
  stroke(#ff0000);

  ////////////////////////////// Dessin de l'espace sur la grille //////////////////////
  /*
  // base centrale
   line(0, 727, 1480, 727); // horizontale bas
   line(188, 955, 738, 00); // oblique gauche
   line(238, 955, 788, 00); // deuxieme oblique gauche
   line(365, 00, 927, 958); // oblique droite
   // coin fumeur haut
   line(98,0,1150,595); // oblique haut
   line(15,0,1150,647); //oblique bas
   line(0,950,550,0); //facade gauche
   // coin fumeur gauche
   line (560,0,1110,955); // facade droite
   line (165,955,1150,420); // couloir gauche
   line (285,955,1150,460); //couloir droite
   // coin fumeur bas droite
   line (0,890,1150,890); // facade avant
   line (715,0,715,955); // couloir gauche
   line (760,0,760,955); // couloir droite
   */
  ///////////////////////////////////////////////////////////////////////////////////////

  stroke(0, 30);
  strokeWeight(1);
  for (int i=0; i<=width; i+=GRID_SIZE) {
    line(i, 0, i, height);
  }
  for (int j=0; j<=height; j+=GRID_SIZE) {
    line(0, j, width, j);
  }

  if (keyPressed && key == 'w') {
    displayColor = false ;
  }

  // ajout d'une position, si la souris est appuyee
  if (mousePressed) {

    int xGrid = mouseX/GRID_SIZE;
    int yGrid = mouseY/GRID_SIZE;
    boolean positionChange = false;

    if (positions.size()==0) {
      positionChange = true;
    } else {
      Position lastPosition = positions.get(positions.size()-1);
      positionChange = lastPosition.x != xGrid || lastPosition.y != yGrid;
    }


    if (positionChange || (millis()-lastInputTime<inputFrenquency)) {
      positions.add(new Position(xGrid, yGrid, randomColor, userIndex, millis()));
      lastInputTime = millis();
    }
  }

  noStroke();

  if (displayColor) {
    for (Position p : positions) {
      fill(p.couleur, 80);
      rect(p.x*GRID_SIZE, p.y*GRID_SIZE, GRID_SIZE, GRID_SIZE);
    }
  }

  for (Position p1 : positions) {
    if (!p1.dejaCroise) {
      for (Position p2 : positions) {
        if (!p2.dejaCroise) {
          if (p1.user != p2.user && p1.match(p2)) {
            croisements.add(new Croisement(p1, p2));
            p1.dejaCroise = p2.dejaCroise = true;
          }
        }
      }
    }
  }

  for (Position p1 : positions) {
    if (!p1.dejaAdditionne) {
      for (PositionSomme ps : positionsSomme) {
        if (ps.x == p1.x && ps.y == p1.y) {
          if (!ps.userExist(p1)) {
            ps.ajoutePosition(p1);
            p1.dejaAdditionne = true;
          }
        }
      }
      if (!p1.dejaAdditionne) {
        positionsSomme.add(new PositionSomme (p1));
      }
      p1.dejaAdditionne = true;
    }
  }

  //          positionsSomme.add(new PositionSomme(p1));


  for (Croisement c : croisements) {
    if (!c.dejaSomme) {
      for (CroisementSomme cs : croisementsSomme) {
        if (cs.x == c.x && cs.y == c.y) {
          cs.add(c);
        }
      }
    }
    if (!c.dejaSomme) {
      croisementsSomme.add(new CroisementSomme(c));
    }
  }


  noFill();
  strokeWeight(2);

  for (CroisementSomme cs : croisementsSomme) {
    stroke(0);
    strokeWeight(cs.croisements.size());
    rect(cs.x*GRID_SIZE, cs.y*GRID_SIZE, GRID_SIZE, GRID_SIZE);
  }  
    for (PositionSomme ps : positionsSomme) {
    stroke(0);
    strokeWeight(ps.positions.size());
    rect(ps.x*GRID_SIZE, ps.y*GRID_SIZE, GRID_SIZE, GRID_SIZE);
  } 

  if (keyPressed) {
    switch(key) {

    case 's' : 
      // enregistre les JSON

      // positons
      JSONArray jsonPositions = new JSONArray();
      int n=0;
      for (Position p : positions) {
        jsonPositions.setJSONObject(n, p.getJSON());
        n++;
      }
      saveJSONArray(jsonPositions, "data/positions.json");

      // croisements
      JSONArray jsonCroisements = new JSONArray();
      n=0;
      for (Croisement c : croisements) {
        jsonCroisements.setJSONArray(n, c.getJSON());
        n++;
      }
      saveJSONArray(jsonCroisements, "data/croisements.json");

      // croisements Somme
      JSONArray jsonCroisementsSomme = new JSONArray();
      n=0;
      for (CroisementSomme cs : croisementsSomme) {
        jsonCroisementsSomme.setJSONObject(n, cs.getJSON());
        n++;
      }
      saveJSONArray(jsonCroisementsSomme, "data/croisementsSomme.json");
      
      // croisements Somme
      JSONArray jsonPositionsSomme = new JSONArray();
      n=0;
      for (PositionSomme ps : positionsSomme) {
        jsonPositionsSomme.setJSONObject(n, ps.getJSON());
        n++;
      }
      saveJSONArray(jsonPositionsSomme, "data/positionsSomme.json");
      
      break;

    case 'p' :
      // copie l'ecran dans un fichier
      int d = day();    
      int m = month();  
      int y = year();     
      int h = hour();  
      int min = minute();  
      saveFrame("Phase-de--rencontre//Helios-rencontre" + d + "-" + m + "-" + y + "-" + "à" + "-" + h + "h"+ min + "min" + ".jpg");
      break;

    case 'u' :
      // envoie les donnees via udp
      new udpRequest();
      break;
    }
  }
}

