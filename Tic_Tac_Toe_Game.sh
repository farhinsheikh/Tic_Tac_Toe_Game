#!/bin/bash -x
echo " Welcome to the Tic Tac Toe Game"

NUM_OF_ROWS=3
NUM_OF_COLUMNS=3
EMPTY=0
LENGTH=$(( $NUM_OF_ROWS * $NUM_OF_COLUMNS ))

playerSymbol=''
computerSymbol=''
cell=1
playerCell=''

declare -A dictBoard
declare -A dictExit

function resetBoard(){
local i=0
local j=0
for ((i=0; i<NUM_OF_ROWS; i++))
	do
		for ((j=0; j<NUM_OF_COLUMNS; J++))
		do
			echo "dictBoard[$i,$j]=EMPTY"
		done
	done
}
#resetBoard

function initializeBoard()
{
	for (( x=0; x<NUM_OF_ROWS; x++ ))
	do
      for (( y=0; y<NUM_OF_COLUMNS; y++ ))
      do
         dictBoard[$x,$y]=$cell
         ((cell++))
      done
   done
}
#initializeBoard

function assignSymbol(){
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
   playerSymbol=X
   computerSymbol=0
   else
   playerSymbol=0
   computerSymbol=X
   fi
}
#assignSymbol

function getToss(){
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      echo "Player should play 1st"
   else
      echo "Computer should play 1st"
   fi
}
#getToss

function displayBoard()
{
	local i=0
   local j=0
   for (( i=0; i<NUM_OF_ROWS; i++ ))
   do
      for (( j=0; j<NUM_OF_COLUMNS; j++ ))
      do
         echo -n "|   ${dictBoard[$i,$j]}   |"
      done
	 printf "\n\n"
   done
}
#displayBoard

function inputToBoard()
{
  local rowIndex=''
  local columnIndex=''

  for (( i=0; i<$LENGTH; i++))
  do
  displayBoard
  read  -p "Choose one cell for input : " playerCell

  if [ $playerCell -gt $LENGTH ]
  then
     echo "Invalid move, Select valid cell"
     printf "\n"
     ((i--))
  else
  rowIndex=$(( $playerCell / $NUM_OF_ROWS ))
     if [ $(( $playerCell % $NUM_OF_ROWS )) -eq 0 ]
     then
        rowIndex=$(( $rowIndex - 1 ))
     fi

  columnIndex=$(( $playerCell %  $NUM_OF_COLUMNS ))
     if [ $columnIndex -eq 0 ]
     then
        columnIndex=$(( $columnIndex + 2 ))
     else
        columnIndex=$(( $columnIndex - 1 ))
     fi

     if [[ "${dictBoard[$rowIndex,$columnIndex]}" -eq "$playerSymbol" ]] || [[ "${dictBoard[$rowIndex,$columnIndex]}" -eq "$computerSymbol" ]]
     then
        echo "Invalid move, Cell already filled"
        printf "\n"
        ((i--))
     fi

     dictBoard[$rowIndex,$columnIndex]=$playerSymbol
  fi
  done
}

assignSymbol
getToss
echo
initializeBoard
inputToBoard
displayBoard
