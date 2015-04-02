

int GRID_SIZE = 7;
int GRID_X = 160;
int GRID_Y = 140;

String RUN_TYPE= "Editor";
//String RUN_TYPE= "Viewer";


void setup() {
if (RUN_TYPE == "Editor")  setupEditor();
if (RUN_TYPE == "Viewer")  setupViewer();
}
void draw() {
  if (RUN_TYPE == "Editor") drawEditor();
  if (RUN_TYPE == "Viewer") drawViewer();

}
void mousePressed(){
  if (RUN_TYPE == "Editor") mousePressedEditor();
}

