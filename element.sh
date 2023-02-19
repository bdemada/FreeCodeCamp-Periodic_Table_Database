#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9] ]]
  then
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, \
        melting_point_celsius, boiling_point_celsius FROM elements \
        FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id)
        WHERE atomic_number = $1")
  else
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, \
        melting_point_celsius, boiling_point_celsius FROM elements \
        FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id)
        WHERE symbol = '$1' OR name ='$1'")
  fi
  if [[ -z $ELEMENT_INFO ]]
  then
    echo "I could not find that element in the database."
  else
#    IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELT BOIL <<< "1|Hydrogen|H|nonmetal|1.008|-259.1|-252.9"
    IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELT BOIL <<< $(echo $ELEMENT_INFO)
#    echo $ELEMENT_INFO | IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELT BOIL
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  fi
fi
