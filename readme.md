Docker - Ping Pong
===================
Par **DOMANGE** Baptiste et **VALENZA** Gauthier.


Prérequis :
-------------
- NodeJS
- NPM
- JQ 

Certain script s'occuperont de faire un apt-get install, il est possible que le mot de passe sudo vous soit demandez.

Pour une meilleure stabilité des scripts et du serveur, il est quand même conseillé de les installer à la main.

Lancement du serveur :
-------------
Lancer le fichier install_start_server.sh avec la commande :

    ./install_start_server.sh
    
Il est possible que nous n'aviez pas les droits, dans ce cas là :

    chmod 777 install_start_server.sh

Puis lancer le serveur avec le fichier.

Lors du lancement vous devrez entrer l'url DSN Sentry, si vous n'entrez pas d'URL nous utiliserons la notre.


Lancement des test unitaires :
-------------
Le serveur doit être lancé avant d'exécuter les tests unitaires.
Lancer le fichier unit_tests.sh avec la commande :

    ./unit_tests.sh
  
 Le script va tester si le serveur est bien lancé, s'il répond à un /ping et s'il renvoi la bonne valeur de pingCount.
   
