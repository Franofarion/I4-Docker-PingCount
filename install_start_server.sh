#!/bin/bash

echo "Installation et lancement de PingCount, serveur NodeJS / Express, fait par G. Valenza et B. Baptiste"

#Check if nodejs is installed on user's computer
if ! [ -x "$(command -v npm)" ]; then
	echo "Installation de NodeJs" 
	sudo apt-get install nodejs
else
	echo "Npm déjà installé sur votre poste"
fi

#Install dependencies of the server Pingcount project into node_modules folder
npm --prefix ./server/ install ./server

echo "Veuillez renseigner votre DSN sentry (si nulle, nous utiliserons une par défault) :"
#User able to use its own DSN sentry log server, if null, a default one is used
read sentry
node server/index.js $sentry
