
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
    int port2        = 6202;    // the destination port
    int i =0;


    JSONArray jsonCroisementsSomme = loadJSONArray("data/croisementsSomme.json"); 
    for (i=0; i<jsonCroisementsSomme.size (); i++) {

      JSONObject jsonCroisementSomme = jsonCroisementsSomme.getJSONObject(i);
      String x = str(jsonCroisementSomme.getInt("x")); // convert int to String
      String y = str(jsonCroisementSomme.getInt("y")); // convert int to String
      String iteration = str(jsonCroisementSomme.getInt("i")); // convert int to String
      String msg = x+";"+y+";"+iteration;
    
    udps.send(x, ip, port); // send msg
    udps.send(y, ip, port2); // send msg
    delay(3000);
    println(msg);
    
   // regarder XML
   
   
    
   /*   class seuil {
  seuil () {

        float CurseurSeuil = 5; // niveau à régler
        int b =0 ;

        for (String iteration = str(jsonCroisementSomme.getInt("i")); iteration <= CurseurSeuil; iteration++) {

          if (iteration <= CurseurSeuil) {

            b = b++;
          }
          println (b);
        }
      }*/

  //println("UDP request successfully send ("+i+"x2 items)");
}}


  }

//}


