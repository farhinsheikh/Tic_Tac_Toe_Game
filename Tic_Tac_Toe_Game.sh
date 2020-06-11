#!/bin/bash -x
echo " Welcome to the Tic Tac Toe Game"

NUM_OF_ROWS=3
NO_OF_COLUMNS=3
EMPTY=-1

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
