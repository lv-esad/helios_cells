
String local_string;
String remote_string;

int GRID_SIZE = 5;
int GRID_X = 160;
int GRID_Y = 140;

Spacebrew sb;

void setup() {

  size(800, 700);
  background(255);
  
  setupSpacebrew();

}

void keyPressed(){
  switch(keyCode){
    case 82 : // R
    ResetInterface();    
    default:
  }
}

void draw() {
}



