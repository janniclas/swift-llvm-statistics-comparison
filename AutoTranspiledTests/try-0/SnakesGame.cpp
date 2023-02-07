
#include <iostream>include <array>
 
struct MyMain {

    static void main() {
        const int finalSquare = 25;
        std::array<int, finalSquare + 1> board = {};
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
    gameLoop:
        while (square != finalSquare) {
            diceRoll += 1;
            if (diceRoll == 7) { diceRoll = 1; }
            switch (square + diceRoll) {
            case finalSquare:
                // diceRoll will move us to the final square, so the game is over
                break;
            case finalSquare + 1:
                // diceRoll will move us beyond the final square, so roll again
                continue gameLoop;
            default:
                // this is a valid move, so find out its effect
                square += diceRoll;
                square += board[square];
            }
        }
    }

};

int main() {
    MyMain::main();
    return 0;
}