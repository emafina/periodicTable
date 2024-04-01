#!/bin/bash
#PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # search as atomic number
    DATA=$($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1;")
  else
    VAR_NAMES=('symbol' 'name') 
    for VAR_NAME in ${VAR_NAMES[@]}
    do 
      DATA=$($PSQL "SELECT atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE $VAR_NAME='$1';")
      if [[ ! -z $DATA ]]
      then
        break
      fi
    done
  fi
fi
if [[ -z $DATA ]]
then
  echo "I could not find that element in the database." 
else
  read NUM BAR SYM BAR NAME BAR MASS BAR MP BAR BP BAR TYPE < <(echo $DATA)
  #echo $DATA | (read NUM BAR SYM BAR NAME BAR MASS BAR MP BAR BP BAR TYPE)
  echo "The element with atomic number $NUM is $NAME ($SYM). It'a $TYPE, with mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
fi
