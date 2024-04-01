#!/bin/bash
#PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

while IFS="," read NUM NAME SYM MASS MP BP TP
do
  echo "$NUM $NAME $SYM $MASS $MP $BP $TP"
  # insert into elements
  RESULT=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES($NUM,'$SYM','$NAME')")
  echo "Insert into elements: $RESULT"
  # search for type_id
  TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type='$TP'")
  echo "Type id: $TYPE_ID"
  # insert into properties
  RESULT=$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES($NUM,'$TP',$MASS,$MP,$BP,$TYPE_ID)")
  echo "Insert into properties: $RESULT"
done
