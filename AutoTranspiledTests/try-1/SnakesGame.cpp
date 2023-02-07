

#include <iostream>

struct MyMain {

    static void main() {
        int finalSquare = 25;
        int board[finalSquare + 1];
        for (int i = 0; i <= finalSquare; i ++){
            board[i] = 0;
        }
        board[3] = 8;
        board[6] = 11;
        board[9] = 9;
        board[10] = 2;
        board[14] = -10;
        board[19] = -11;
        board[22] = -2;
        board[24] = -8;
        int square = 0;
        int diceRoll = 0;

        while (square != finalSquare){
            diceRoll++;
            if (diceRoll == 7) {
                diceRoll=1;
            }

            int newSquare = square + diceRoll;
            if (newSquare == finalSquare) {
                break;
            } else if (newSquare > finalSquare){
                continue;
            } else {
                square += diceRoll;
                square += board[square];
            }
        }
    }

};