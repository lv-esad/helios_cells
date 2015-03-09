
/// Le but est d'envoyer en udp sur le port 6201 la position X et Y des croisements récupéré dans le JSON (actualisation ?)

import hypermedia.net.*;
UDP udps; 
int CroisementDate ;
int CroisementUser;
int CroisementPosX;
int CroisementPosY;

class udp {

  
JSONObject json;
JSONArray values;

json = loadJSONObject ("data//croisements.json"); // unexpected token:json ???


  float date = 0;
  float user = 0;
  float y = 0;
  float x = 0;
  
  JSONObject pos = null;
 
   CroisementDate = pos.getInt("date");
   CroisementUser = pos.getInt("user");
   CroisementPosX = pos.getInt("x");
   CroisementPosY = pos.getInt("y");
  
 String ip       = "127.0.0.1";  // the remote IP address
 int port        = 6201;    // the destination port
 udps.send("CroisementPosX +  CroisementPosY" , ip, port); // bug

  }

