
/// Le but est d'envoyer en udp sur le port 6201 la position X et Y des croisements récupéré dans le JSON (actualisation ?)

import hypermedia.net.*;

class udpRequest {

  UDP udps; 

  udpRequest() {
    // dans processing, une classe doit avoir un constructeur
    // ce constructeur a le meme nom que la classe
    //
    println("sending UDP request ..."); 
    udps = new UDP( this, 0 );
    String ip       = "127.0.0.1";  // the remote IP address
    int port        = 6201;    // the destination port
    int i =0;

    /*
    JSONArray jsonCroisements = loadJSONArray("data/croisements.json"); 
    for (i=0; i<jsonCroisements.size(); i++) {
      //
      JSONArray jsonCroisement = jsonCroisements.getJSONArray(i);
      JSONObject jsonP1 = jsonCroisement.getJSONObject(0);
      String x = str(jsonP1.getInt("x")); // convert int to String
      String y = str(jsonP1.getInt("y")); // convert int to String
      udps.send(x, ip, port); // send X as String
      udps.send(y, ip, port); // send Y as String
    }
    */
    //*
    JSONArray jsonCroisementsSomme = loadJSONArray("data/croisementsSomme.json"); 
    for (i=0; i<jsonCroisementsSomme.size(); i++) {
      //
      JSONObject jsonCroisementSomme = jsonCroisementsSomme.getJSONObject(i);
      String x = str(jsonCroisementSomme.getInt("x")*100); // convert int to String
      String y = str(jsonCroisementSomme.getInt("y")*100); // convert int to String
      String iteration = str(jsonCroisementSomme.getInt("i")); // convert int to String
      String msg = x+";"+y+";"+iteration;
      udps.send(msg, ip, port); // send msg
      delay(50);
      println(msg);
    }
    //*/
    //
    println("UDP request successfully send ("+i+"x2 items)");
    

  }
}

