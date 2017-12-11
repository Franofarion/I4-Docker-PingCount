#!/bin/bash

echo "Installation et lancement de PingCount, serveur NodeJS / Express, fait par G. Valenza et B. Baptiste"

if ! [ -x "$(command -v npm)" ]; then
	echo "Installation de NodeJs" 
	sudo apt-get install nodejs
else
	echo "Npm déjà installé sur votre poste"
fi

npm --prefix ./server/ install ./server

echo "Veuillez renseigner votre DSN sentry (si nulle, nous utiliserons une par défault) :"
read sentry
node server/index.js $sentry
