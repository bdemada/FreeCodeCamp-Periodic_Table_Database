#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

cat ../atomic_mass.txt | while read ATOMIC_NUMBER BAR ATOMIC_MASS
do
  if [[ $ATOMIC_NUMBER != "atomic_number" ]]
  then
    INSERTION=$($PSQL "UPDATE properties SET atomic_mass = $ATOMIC_MASS WHERE atomic_number=$ATOMIC_NUMBER")
    echo $INSERTION
  fi
done
