
int GRID_SIZE = 7;
int GRID_X = 160;
int GRID_Y = 140;
color randomColor;
int userIndex = 0;

int lastInputTime = 0;
int inputFrenquency = 100;

PImage plan;

ArrayList<Position> positions = new ArrayList<Position>();
ArrayList<Croisement> croisements = new ArrayList<Croisement>();

void setup(){
  
  plan = loadImage("plan.png");
  GRID_Y = GRID_X*plan.height/plan.width;
  size(GRID_SIZE*GRID_X+1,GRID_SIZE*GRID_Y+1);
  
}

void mousePressed(){
  randomColor = color(random(128)+128,random(128)+128,random(128)+128);
  userIndex ++;
}

void draw(){
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
<<<<<<< HEAD
  if(displayColor){
=======
  noStroke();
>>>>>>> c84d363df7753452a22623abd1b08fc5323e5130
  for(Position p : positions){
    fill(p.couleur,80);
    rect(p.x*GRID_SIZE,p.y*GRID_SIZE,GRID_SIZE,GRID_SIZE);
  }
<<<<<<< HEAD
  }
=======
  
  croisements = new ArrayList<Croisement>();
  
  for(Position p1: positions){
    for(Position p2: positions){
      if(p1.user != p2.user && p1.match(p2)){
        croisements.add(new Croisement(p1,p2));
        noFill();
        stroke(p1.invertColor,40);
        rect(p1.x*GRID_SIZE,p1.y*GRID_SIZE,GRID_SIZE,GRID_SIZE);
      }
    }
  }
  
>>>>>>> c84d363df7753452a22623abd1b08fc5323e5130
  
}
