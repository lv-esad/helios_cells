import spacebrew.*;

String server="localhost";
String name="processing display";
String description ="Client that sends and receives position messages.";


void setupSpacebrew(){
  
  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addPublish( "command", "string", "hello world" ); 

  // declare your subscribers
  sb.addSubscribe( "position", "string" );
  //sb.addSubscribe( "message", "string" );

  // connect!
  sb.connect(server, name, description );
  
}

void ResetInterface(){
  sb.send("command","reset");
}

void onStringMessage( String name, String value ) {
   
  JSONObject json = JSONObject.parse(value);
  long timestamp = json.getInt("timestamp");
  
  if(timestamp!=0){

  int x = json.getInt("x");
  int y = json.getInt("y");
  String colorString = split(json.getString("color"),"#")[1];
  int colorInt = unhex(colorString);
  color c = color(red(colorInt),green(colorInt),blue(colorInt),255/10);
  int uid = json.getInt("uid");
  int ts = json.getInt("timestamp");
  
    /* * /
  // debug raw message
  fill(c);
  noStroke();
  rect(x*GRID_SIZE, y*GRID_SIZE, GRID_SIZE, GRID_SIZE);
  
  //*/
  AddPosition(x,y,c,uid,ts);
  
 }
  
}

void CleanInterface(){
    println("clean interface");
    sb.send("command","clean"); 
}
