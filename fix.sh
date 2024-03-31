#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

RESULT=$($PSQL "SELECT * FROM properties;")
echo "$RESULT" | while read ATOMIC_NUMBER BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT
