#/bin/bash!
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1  ]]
then
 echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
 NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
 if [[ -z $NUMBER ]]
 then
  echo "I could not find that element in the database."
 else
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$NUMBER;")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$NUMBER;")
  TYPE=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$NUMBER;")
  if [[ $TYPE==2 ]]
  then
   TYPE="nonmetal"
  elif [[ $TYPE==1 ]]
  then
   TYPE="metal"
  else
   TYPE="metalloid"
  fi
  MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$NUMBER;")
  MELT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$NUMBER;")
  BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$NUMBER;")
  echo "The element with atomic number $1 is ${NAME// /} (${SYMBOL// /}). It's a ${TYPE// /}, with a mass of ${MASS// /} amu. ${NAME// /} has a melting point of ${MELT// /} celsius and a boiling point of ${BOIL// /} celsius."
 fi
else
 SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1';")
 if [[ -z $SYMBOL ]]
 then
  NAME=$($PSQL "SELECT name FROM elements WHERE name='$1';")
  if [[ -z $NAME ]]
  then
   echo "I could not find that element in the database."
  else
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1';")
  ATOM=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
  TYPE=$($PSQL "SELECT type_id FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1';")
  if [[ $TYPE==2 ]]
  then
   TYPE="nonmetal"
  elif [[ $TYPE==1 ]]
  then
   TYPE="metal"
  else
   TYPE="metalloid"
  fi
  MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1';")
  MELT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1';")
  BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1';")
  echo "The element with atomic number ${ATOM// /} is $1 (${SYMBOL// /}). It's a ${TYPE// /}, with a mass of ${MASS// /} amu. $1 has a melting point of ${MELT// /} celsius and a boiling point of ${BOIL// /} celsius."
  fi
 else
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1';")
  if [[ -z $SYMBOL ]]
  then
   echo "I could not find that element in the database."
  else
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1';")
  ATOM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
  TYPE=$($PSQL "SELECT type_id FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1';")
  if [[ $TYPE==2 ]]
  then
   TYPE="nonmetal"
  elif [[ $TYPE==1 ]]
  then
   TYPE="metal"
  else
   TYPE="metalloid"
  fi
  MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1';")
  MELT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1';")
  BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1';")
  echo "The element with atomic number ${ATOM// /} is ${NAME// /} (${SYMBOL// /}). It's a ${TYPE// /}, with a mass of ${MASS// /} amu. ${NAME// /} has a melting point of ${MELT// /} celsius and a boiling point of ${BOIL// /} celsius."
  fi
 fi
fi