import spacebrew.*;

String server="localhost";
String name="processing display";
String description ="Client that sends and receives position messages.";

String local_string;
String remote_string;

Spacebrew sb;

void setup(){
  	size(550, 550);
  background(255);

  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );
  
  // declare your publishers
  sb.addPublish( "sendPosition", "string", local_string ); 

  // declare your subscribers
  sb.addSubscribe( "sendPosition", "string" );

  // connect!
  sb.connect(server, name, description );
}

void draw(){
}

void onStringMessage( String name, String value ){
  JSONObject json = JSONObject.parse(value);
  json.parse(value);
  
  println(json);
  set(json.getInt("x"),json.getInt("y"),0);
  
  remote_string = value;
}
