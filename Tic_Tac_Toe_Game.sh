#!/bin/bash -x
echo " Welcome to the Tic Tac Toe Game"

NUM_OF_ROWS=3
NUM_OF_COLUMNS=3
EMPTY=0
PLAYER_SYMBOLBOL=''
COMPUTER_SYMBOL=''
LENGTH=$(( $NUM_OF_ROWS * $NUM_OF_COLUMNS ))

cell=1
playerCell=''
playerTurn=''

declare -A board

function resetBoard()
{
   local i=0
   local j=0

   for ((i=0; i<NUM_OF_ROWS; i++))
   do
      for ((j=0; j<NUM_OF_COLUMNS; j++))
      do
         board[$i,$j]=$EMPTY
      done
   done
}
#resetBoard

function initializeBoard()
{
   local x=0
   local y=0
   for (( x=0; x<NUM_OF_ROWS; x++ ))
   do
      for (( y=0; y<NUM_OF_COLUMNS; y++ ))
      do
         board[$x,$y]=$cell
         ((cell++))
      done
   done
}
initializeBoard

function assigningSymbol()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      PLAYER_SYMBOL=X
      COMPUTER_SYMBOL=O
   else
      COMPUTER_SYMBOL=X
      PLAYER_SYMBOL=O
   fi
   echo "Player's Symbol - $PLAYER_SYMBOL"
}
assigningSymbol

function toss()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      playerTurn=1
      echo "Player should play first"
   else
      playerTurn=0
      echo "Computer should play first"
   fi
}
toss

function displayBoard()
{
   echo "-- TicTacToe Board --"
   local i=0
   local j=0
   for (( i=0; i<NUM_OF_ROWS; i++ ))
   do
      for (( j=0; j<NUM_OF_COLUMNS; j++ ))
      do
         echo -n "  ${board[$i,$j]}  "
      done
	 printf "\n"
   done
}

function inputToBoard()
{
   local rowIndex=''
   local columnIndex=''

   for (( i=0; i<$LENGTH; i++))
   do
      echo "--------------------------"
      displayBoard
      if [ $playerTurn -eq 1 ]
      then
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

               if [ "${board[$rowIndex,$columnIndex]}" == "$PLAYER_SYMBOL" ] | [ "${board[$rowIndex,$columnIndex]}" == "$COMPUTER_SYMBOL" ]
               then
                  echo "Invalid move, Cell already filled"
                  printf "\n"
                  ((i--))
               else
                  board[$rowIndex,$columnIndex]=$PLAYER_SYMBOL
                  playerTurn=0

                  if [ $(checkWinner $PLAYER_SYMBOL) -eq 1  ]
                  then
                     echo "You Won"
                     return 0
                  fi
               fi
            fi
      else
         echo "---- Computer's Turn ----"
			checkForComputerWin
         computerTurn
         playerTurn=1
         if [ $(checkWinner $COMPUTER_SYMBOL) -eq 1  ]
         then
            echo "Computer Won"
            return 0
         fi
      fi
   done
   echo "Match Tie"
}

function checkWinner()
{
   symbol=$1

   if [ ${board[0,0]} == $symbol ] && [ ${board[0,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[1,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[1,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[2,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,0]} == $symbol ] && [ ${board[2,0]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,1]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,1]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,2]} == $symbol ] && [ ${board[1,2]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[0,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${board[2,0]} == $symbol ] && [ ${board[1,1]} == $symbol ] && [ ${board[0,2]} == $symbol ]
   then
      echo 1
   else
      echo 0
   fi
}

function  computerTurn(){
#for Rows
   local row=0
   local column=0
   for ((row=0; row<NUM_OF_ROWS; row++))
   do 
      if [ ${board[$row,$column]} == $PLAYER_SYMBOL ] && [ ${board[$(($row)),$(($column+1))]} == $PLAYER_SYMBOL ]
      then
          if [ ${board[$row,$(($column+2))]} != $COMPUTER_SYMBOL ]
          then
             board[$row,$(($column+2))]=$COMPUTER_SYMBOL
             break
          fi
      elif [ ${board[$row,$(($column+1))]} == $PLAYER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $PLAYER_SYMBOL ]
      then
          if [ ${board[$row,$column]} != $COMPUTER_SYMBOL ]
          then
             board[$row,$column]=$COMPUTER_SYMBOL
             break
          fi
      elif [ ${board[$row,$column]} == $PLAYER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $PLAYER_SYMBOL ]
      then
          if [ ${board[$row,$(($column+1))]} != $COMPUTER_SYMBOL ]
          then
             board[$row,$(($column+1))]=$COMPUTER_SYMBOL
             break
          fi
      fi
   done

#For Columns

   local row=0
   local column=0
   for ((column=0; column<NUM_OF_COLUMNS; column++))
   do
      if [ ${board[$row,$column]} == $PLAYER_SYMBOL ] &&  [ ${board[$(($row+1)),$column]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$(($row+2)),$column]} != $COMPUTER_SYMBOL ]
         then
            board[$(($row+2)),$column]=$COMPUTER_SYMBOL
            break
         fi
      elif [ ${board[$(($row+1)),$column]} == $PLAYER_SYMBOL ] && [ ${board[$(($row+2)),$column]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$row,$column]} != $COMPUTER_SYMBOL ]
         then
            board[$row,$column]=$COMPUTER_SYMBOL
            break
          fi
      elif [ ${board[$row,$column]} == $PLAYER_SYMBOL ] && [ ${board[$(($row+2)),$column]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$(($row+1)),$column]} != $COMPUTER_SYMBOL ]
         then
            board[$(($row+1)),$column]=$COMPUTER_SYMBOL
            break
         fi
      fi
   done

#For Diagonal

      local row=0
      local column=0
      local valid=''

      if [ ${board[$row,$column]} == $PLAYER_SYMBOL ] &&  [ ${board[$(($row+1)),$(($column+1))]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$(($row+2)),$(($column+2))]} != $COMPUTER_SYMBOL ]
         then
            board[$(($row+2)),$(($column+2))]=$COMPUTER_SYMBOL
            return
         fi
      elif [ ${board[$(($row+1)),$(($column+1))]} == $PLAYER_SYMBOL ] && [ ${board[$(($row+2)),$(($column+2))]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$row,$column]} != $COMPUTER_SYMBOL ]
         then
            board[$row,$column]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$row,$column]} == $PLAYER_SYMBOL ] && [ ${board[$(($row+2)),$(($column+2))]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$(($row+1)),$(($column+1))]} != $COMPUTER_SYMBOL ]
         then
            board[$(($row+1)),$(($column+1))]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$(($row+2)),$column]} == $PLAYER_SYMBOL ] &&  [ ${board[$(($row+1)),$(($column+1))]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$row,$(($column+2))]} != $COMPUTER_SYMBOL ]
         then
            board[$row,$(($column+2))]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$(($row+1)),$(($column+1))]} == $PLAYER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$(($row+2)),$column]} != $COMPUTER_SYMBOL ]
         then
            board[$(($row+2)),$column]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$(($row+2)),$column]} == $PLAYER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $PLAYER_SYMBOL ]
      then
         if [ ${board[$(($row+1)),$(($column+1))]} != $COMPUTER_SYMBOL ]
         then
            board[$(($row+1)),$(($column+1))]=$COMPUTER_SYMBOL
            return
          fi
      else
         while [ true ]
         do
            local row=$(( RANDOM % $NUM_OF_ROWS ))
            local column=$(( RANDOM % $NUM_OF_COLUMNS ))

            if [ ${board[$row,$column]} == $PLAYER_SYMBOL ] | [ ${board[$row,$column]} == $COMPUTER_SYMBOL ]
            then
               continue
            else
               board[$row,$column]=$COMPUTER_SYMBOL
               break
            fi
         done
      fi
}

function checkForComputerWin()
{

   local row=0
   local column=0
   for ((row=0; row<NUM_OF_ROWS; row++))
   do
      if [ ${board[$row,$column]} == $COMPUTER_SYMBOL ] && [ ${board[$(($row)),$(($column+1))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$row,$(($column+2))]} != $PLAYER_SYMBOL ]
          then
             board[$row,$(($column+2))]=$COMPUTER_SYMBOL
             break
          fi
      elif [ ${board[$row,$(($column+1))]} == $COMPUTER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $COMPUTER_SYMBOL ]
      then
          if [ ${board[$row,$column]} != $PLAYER_SYMBOL ]
          then
             board[$row,$column]=$COMPUTER_SYMBOL
             break
          fi
      elif [ ${board[$row,$column]} == $COMPUTER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $COMPUTER_SYMBOL ]
      then
          if [ ${board[$row,$(($column+1))]} != $PLAYER_SYMBOL ]
          then
             board[$row,$(($column+1))]=$COMPUTER_SYMBOL
             break
          fi
      fi
   done


   local row=0
   local column=0
   for ((column=0; column<NUM_OFCOLUMNS; column++))
   do
      if [ ${board[$row,$column]} == $COMPUTER_SYMBOL ] &&  [ ${board[$(($row+1)),$column]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$(($row+2)),$column]} != $PLAYER_SYMBOL ]
         then
            board[$(($row+2)),$column]=$COMPUTER_SYMBOL
            break
         fi
      elif [ ${board[$(($row+1)),$column]} == $COMPUTER_SYMBOL ] && [ ${board[$(($row+2)),$column]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$row,$column]} != $PLAYER_SYMBOL ]
         then
            board[$row,$column]=$COMPUTER_SYMBOL
            break
          fi
      elif [ ${board[$row,$column]} == $COMPUTER_SYMBOL ] && [ ${board[$(($row+2)),$column]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$(($row+1)),$column]} != $PLAYER_SYMBOL ]
         then
            board[$(($row+1)),$column]=$COMPUTER_SYMBOL
            break
         fi
      fi
   done


      local row=0
      local column=0
      local valid=''

      if [ ${board[$row,$column]} == $COMPUTER_SYMBOL ] &&  [ ${board[$(($row+1)),$(($column+1))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$(($row+2)),$(($column+2))]} != $PLAYER_SYMBOL ]
         then
            board[$(($row+2)),$(($column+2))]=$COMPUTER_SYMBOL
            return
         fi
      elif [ ${board[$(($row+1)),$(($column+1))]} == $COMPUTER_SYMBOL ] && [ ${board[$(($row+2)),$(($column+2))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$row,$column]} != $PLAYER_SYMBOL ]
         then
            board[$row,$column]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$row,$column]} == $COMPUTER_SYMBOL ] && [ ${board[$(($row+2)),$(($column+2))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$(($row+1)),$(($column+1))]} != $PLAYER_SYMBOL ]
         then
            board[$(($row+1)),$(($column+1))]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$(($row+2)),$column]} == $COMPUTER_SYMBOL ] &&  [ ${board[$(($row+1)),$(($column+1))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$row,$(($column+2))]} != $PLAYER_SYMBOL ]
         then
            board[$row,$(($column+2))]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$(($row+1)),$(($column+1))]} == $COMPUTER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$(($row+2)),$column]} != $PLAYER_SYMBOL ]
         then
            board[$(($row+2)),$column]=$COMPUTER_SYMBOL
            return
          fi
      elif [ ${board[$(($row+2)),$column]} == $COMPUTER_SYMBOL ] && [ ${board[$row,$(($column+2))]} == $COMPUTER_SYMBOL ]
      then
         if [ ${board[$(($row+1)),$(($column+1))]} != $PLAYER_SYMBOL ]
         then
            board[$(($row+1)),$(($column+1))]=$COMPUTER_SYMBOL
            return
          fi
      else
         return
      fi
}

inputToBoard
displayBoard
