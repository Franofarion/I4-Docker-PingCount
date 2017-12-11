#!/bin/bash
if ! [ -x "$(command -v jq)" ]; then
	echo "Installation de jq pour les tests unitaire"
	sudo apt get install jq -Y
else
	echo "jq déjà installé sur votre poste"
fi


echo "Lancements des tests unitaires de PingCount : " 

echo "Test localhost:3000/"
curl localhost:3000/ -w "\n" | jq -r '."pingCount"'

echo "Test localhost:3000/count"
curl -s localhost:3000/count -w "\n"

NUMBER=$[ ( $RANDOM % 10 )  + 1 ]

for i in `seq 0 $NUMBER`;
do 
	echo "Test localhost:3000/ping"
	curl localhost:3000/ping -w "\n" 
	
done

echo "Test localhost:3000/count"
curl localhost:3000/count -w "\n"
