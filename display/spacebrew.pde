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
  sb.addSubscribe( "message", "string" );

  // connect!
  sb.connect(server, name, description );
  
}

void ResetInterface(){
  sb.send("command","reset");
}

void onStringMessage( String name, String value ) {
    println("position_"+name+"_");
    println(name.length());
  if(name=="position"){
    JSONObject json = JSONObject.parse(value);
    json.parse(value);
    println(json);
    
    /* */
  // debug raw message
  String colorString = split(json.getString("color"),"#")[1];
  int colorInt = unhex(colorString);
  color c = color(red(colorInt),green(colorInt),blue(colorInt),255/10);
  fill(c);
  noStroke();
  rect(json.getInt("x")*GRID_SIZE, json.getInt("y")*GRID_SIZE, GRID_SIZE, GRID_SIZE);
  
  //*/
  
  }
  if(name=="message"){
    println(value);
  }
  


  

}
