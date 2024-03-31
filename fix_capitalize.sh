#!/bin/bash
#PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

RESULT=$($PSQL "SELECT * FROM elements;")
echo "$RESULT" | while read NUMBER BAR SYMBOL BAR NAME 
do
  CAPITALIZED=$(echo "$SYMBOL" | sed 's/./\u&/')
  RESULT=$($PSQL "UPDATE elements SET symbol='$CAPITALIZED' WHERE atomic_number=$NUMBER")
  echo "$SYMBOL turned into $CAPITALIZED"
done
