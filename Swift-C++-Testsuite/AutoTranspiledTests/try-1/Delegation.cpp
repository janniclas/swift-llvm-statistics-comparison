 

#include <iostream> 

class DiceGameTracker : public DiceGameDelegate { 
    
    int numberOfTurns = 0; 
    
    void gameDidStart(DiceGame* game) override { 
        numberOfTurns = 0; 
        if (dynamic_cast<SnakesAndLadders*>(game)) 
            std::cout << "Started a new game of Snakes and Ladders" << std::endl; 
        std::cout << "The game is using a " << game->dice.sides << "-sided dice" << std::endl; 
    } 
    void game(DiceGame* game, int diceRoll) override { 
        numberOfTurns ++; 
        std::cout << "Rolled a " << diceRoll << std::endl;  
    } 
    void gameDidEnd(DiceGame* game) override { 
        std::cout << "The game lasted for " << numberOfTurns  << " turns" << std::endl; 
    } 
}; 

class SnakesAndLadders : public DiceGame { 
    
    int finalSquare = 25;
    Dice dice = {6, new LinearCongruentialGenerator()}; 
    int square = 0; 
    int board[26] {0}; 

    SnakesAndLadders() {
        board[3] = 8;
        board[6] = 11;
        board[9] = 9;
        board[10] = 2;
        board[14] = -10;
        board[19] = -11;
        board[22] = -2;
        board[24] = -8;
    }
    
    DiceGameDelegate* delegate = new DiceGameTracker(); 
    
    void play() override { 
        square = 0;
        delegate->gameDidStart(this); 
        while (square != finalSquare) { 
            int diceRoll = dice.roll(); 
            delegate->game(this, diceRoll); 
            if (square + diceRoll == finalSquare)
                break; 
            else if (square + diceRoll > finalSquare)
                continue;  
            else {
                square += diceRoll;
                square += board[square];
            }
        }
        delegate->gameDidEnd(this);
    }  
};

struct MyMain {

    static void main() {
        DiceGameTracker* tracker = new DiceGameTracker(); 
        SnakesAndLadders* game = new SnakesAndLadders(); 
        game->delegate = tracker; 
        game->play(); 
    }

};

int main() {
   MyMain::main(); 
   return 0;
}