#!/bin/bash
#PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

LAST_ID=0

RESULT=$($PSQL "SELECT * FROM properties;")
echo "$RESULT" | while read ATOMIC_NUMBER BAR ELEMENT_TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
do
  echo "$ATOMIC_NUMBER $ELEMENT_TYPE"
  # search for atomic type in types
  TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type='$ELEMENT_TYPE'")
  # if type not found
  if [[ -z $TYPE_ID ]]
  then
    # insert type into types
    ((++LAST_ID));
    RESULT=$($PSQL "INSERT INTO types(type_id,type) VALUES($LAST_ID,'$ELEMENT_TYPE')");
    if [[ $RESULT = 'INSERT 0 1' ]]
    then
      echo "Type $ELEMENT_TYPE inserted with ID=$LAST_ID"
    else
      echo "Type insert failed"
    fi
    TYPE_ID=$LAST_ID
  fi
  # insert type id into properties
  RESULT=$($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE atomic_number=$ATOMIC_NUMBER")
  echo $RESULT
done
