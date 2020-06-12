#!/bin/bash -x
echo " Welcome to the Tic Tac Toe Game"

NUM_OF_ROWS=3
NO_OF_COLUMNS=3
EMPTY=-1
SYMBOL1=X
SYMBOL2=0

declare -a dictBoard

function resetBoard(){
for ((i=0; i<NUM_OF_ROWS; i++))
	do
		for ((j=0; j<NUM_OF_COLUMNS; J++))
		do
			echo "dictBoard[$i,$j]=EMPTY"
		done
	done
}
resetBoard

function getSymbol(){
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
   echo "playerSymbol=$SYMBOL1"
   echo "computerSymbol=$SYMBOL2"
   else
   echo "playerSymbol=$SYMBOL2"
   echo "computerSymbol=$SYMBOL1"
   fi
}
getSymbol

function getToss(){
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      echo "Player should play 1st"
   else
      echo "Computer should play 1st"
   fi
}
getToss
