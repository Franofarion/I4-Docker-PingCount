#!/bin/bash
if ! [ -x "$(command -v jq)" ]; then
	printf "Installation de jq pour les tests unitaire"
	sudo apt get install jq
else
	printf "jq déjà installé sur votre poste"
fi


clear
$TESTPASSED
printf "Lancements des tests unitaires de PingCount : \n\n\n" 

printf "Test localhost:3000 : It should respond something:\n"
MESSAGE=$(curl localhost:3000/ -s | grep Hello)
echo $MESSAGE
if ! [ -z "$MESSAGE" ]; then
	printf "Test passed."
	TESTPASSED=$((TESTPASSED + 1))
else
	printf "Test not passed"
fi


printf "\n\nTest localhost:3000/ping : It should respond pong:\n"
PONG=$(curl -s localhost:3000/ping -w "\n" | jq -r '.message')
echo $PONG 
if [ $PONG = "pong" ]; then
	printf "Test passed."
	TESTPASSED=$((TESTPASSED + 1))
else
	printf "Test not passed"
fi

NUMBER=$[ ( $RANDOM % 10 )  + 1 ]
printf "\n\nTest localhost:3000/count : It should add %s to current count\n" "$NUMBER"
BASE=$(curl -s localhost:3000/count -w "\n" | jq -r '.pingCount') 
printf "Before test  : %s\n" "$BASE"

for i in `seq 1 $NUMBER`;
do 
	curl localhost:3000/ping -w "\n" > /dev/null 2>&1	
done

AFTER=$(curl -s localhost:3000/count -w "\n" | jq -r '.pingCount') 
printf "After test  : %s\n" "$AFTER"

if [ $((AFTER - NUMBER)) = $BASE  ]; then
	printf "Test passed.\n"
	TESTPASSED=$((TESTPASSED + 1))
else
	printf "Test not passed\n"
fi

printf "\n\n%s/3 tests passed \n" "$TESTPASSED"
