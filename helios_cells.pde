import hypermedia.net.*;

int GRID_SIZE = 7;
int GRID_X = 160;
int GRID_Y = 140;
color randomColor;
int userIndex = 0;

int lastInputTime = 0;
int inputFrenquency = 100;
  

int d = day();    
int m = month();  
int y = year();     
int h = hour();  
int min = minute();

PImage plan;

ArrayList<Position> positions = new ArrayList<Position>();
ArrayList<Croisement> croisements = new ArrayList<Croisement>();

void setup(){
  udps = new UDP( this, 0 );
  plan = loadImage("plan.png");
  GRID_Y = GRID_X*plan.height/plan.width;
  size(GRID_SIZE*GRID_X+1,GRID_SIZE*GRID_Y+1);
  
}

void mousePressed(){
  randomColor = color(random(128)+128,random(128)+128,random(128)+128);
  userIndex ++;
}

void draw(){
  
  if(keyPressed && key == 'p'){
  saveFrame("Phase-de--rencontre//Helios-rencontre" + d + "-" + m + "-" + y + "-" + "à" + "-" + h + "h"+ min + "min" + ".jpg");
  }
      
      
  boolean displayColor = true;
  // dessine la grille
  background(255);
  image(plan,0,0,width,height);
  stroke(0,30);
  strokeWeight(1);
  for(int i=0; i<=width; i+=GRID_SIZE){
    line(i,0,i,height);
  }
  for(int j=0; j<=height; j+=GRID_SIZE){
    line(0,j,width,j);
  }
  
  if(keyPressed && key == 'w'){
  displayColor = false ;
  
  }
  
  // ajout d'une position, si la souris est appuyee
  if(mousePressed){
    
    int xGrid = mouseX/GRID_SIZE;
    int yGrid = mouseY/GRID_SIZE;
    boolean positionChange = false;
    
    if(positions.size()==0){
      positionChange = true;
    }else{
      Position lastPosition = positions.get(positions.size()-1);
      positionChange = lastPosition.x != xGrid || lastPosition.y != yGrid;
    }
    
    
    if(positionChange || (millis()-lastInputTime<inputFrenquency)){
      positions.add(new Position(xGrid,yGrid,randomColor,userIndex,millis()));
      lastInputTime = millis();
    }


  }

  noStroke();
  
  if(displayColor){
  for(Position p : positions){
    fill(p.couleur,80);
    rect(p.x*GRID_SIZE,p.y*GRID_SIZE,GRID_SIZE,GRID_SIZE);
  }
  }
  
  for(Position p1: positions){
    if(!p1.dejaCroise){
        for(Position p2: positions){
         if(!p2.dejaCroise){
           if(p1.user != p2.user && p1.match(p2)){
              croisements.add(new Croisement(p1,p2));
              p1.dejaCroise = p2.dejaCroise = true;
           }
        }
      }
    }
  }

  
  noFill();
  strokeWeight(2);
  
  
  for(Croisement c : croisements){
    stroke(c.p1.invertColor,100);
    rect(c.p1.x*GRID_SIZE,c.p1.y*GRID_SIZE,GRID_SIZE,GRID_SIZE);
  }
  
  println(croisements.size());
  
  if(keyPressed && key=='s'){
    // positons
      JSONArray jsonPositions = new JSONArray();
      int n=0;
      for(Position p : positions){
        jsonPositions.setJSONObject(n,p.getJSON());
        n++;
      }
      saveJSONArray(jsonPositions, "data/positions.json");
      
     // croisements
     JSONArray jsonCroisements = new JSONArray();
      n=0;
      for(Croisement c : croisements){
        jsonCroisements.setJSONArray(n,c.getJSON());
        n++;
      }
      saveJSONArray(jsonCroisements, "data/croisements.json");
  }


  
}
