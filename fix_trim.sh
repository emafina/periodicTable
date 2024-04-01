#!/bin/bash
#PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

RESULT=$($PSQL "SELECT * FROM properties;")
echo "$RESULT" | while read NUM BAR TYPE BAR MASS BAR MP BAR BP BAR TID 
do
  MASS_STRING=$(printf $MASS | sed -E 's/0+$//')
  RESULT=$($PSQL "UPDATE properties SET atomic_mass=$MASS_STRING WHERE atomic_number=$NUM")
  echo "$NUM - $RESULT"
done
