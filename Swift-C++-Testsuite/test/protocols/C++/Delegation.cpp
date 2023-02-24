#include <math.h>
#include <iostream>
#include <ctime>
#include <optional>



class RandomNumberGenerator {
public:
    virtual double random() = 0;
};


class Dice {
private:
    RandomNumberGenerator* generator;
public:
    int sides;
    Dice(int sides, RandomNumberGenerator* generator) {
        this->sides = sides;
        this->generator = generator;
    }
    int roll() {
        return (int)(generator->random() * sides) + 1;
    }
};

class LinearCongruentialGenerator : public RandomNumberGenerator {
private:
    double lastRandom = 42.0;
    const double m = 139968.0;
    const double a = 3877.0;
    const double c = 29573.0;
public:
    double random() {
        lastRandom = fmod((lastRandom * a + c), m);
        return lastRandom / m;
    }
};

class DiceGame {
public:
    virtual Dice* getDice() = 0;
    virtual void play() = 0;
};

class DiceGameDelegate {
    public: 
        virtual void gameDidStart(DiceGame* game) = 0;
        virtual void game(DiceGame* game, int diceRoll) = 0;
        virtual void gameDidEnd(DiceGame* game) = 0;
};

class SnakesAndLadders : public DiceGame {
private:
    const int finalSquare = 25;
    Dice* dice;
    int square = 0;
    int board[26];
public:
    SnakesAndLadders() {
        dice = new Dice(6, new LinearCongruentialGenerator());
        std::fill_n(board, 26, 0);
        board[3] = 8;
        board[6] = 11;
        board[9] = 9;
        board[10] = 2;
        board[14] = -10;
        board[19] = -11;
        board[22] = -2;
        board[24] = -8;
    }
    Dice* getDice() {
        return dice;
    }
   std::optional<DiceGameDelegate*> delegate;

   void play() {
    square = 0;
    if(delegate) {
        delegate.value()->gameDidStart(this);
    }
    while(square != finalSquare) {
        int diceRoll;
        diceRoll = dice->roll();
        if(delegate) {
            delegate.value()->game(this, diceRoll);
        }
        int roleResult = square + diceRoll;
        if (roleResult == this->finalSquare) {
            goto gameEnd;
        } else if ( roleResult > finalSquare) {
            // continue gameLoop;
        } else {
            square += diceRoll;
            square += board[square];
        }
    }
    gameEnd:
    if(delegate) {
        delegate.value()->gameDidEnd(this);
    }
}
};

class DiceGameTracker: public DiceGameDelegate {
private:
    int numberOfTurns = 0;
public:
    void gameDidStart(DiceGame* game) {
    numberOfTurns = 0;
    if (dynamic_cast<SnakesAndLadders*>(game) != NULL) {
        std::cout << "Started a new game of Snakes and Ladders" << std::endl;
    }    
    std::cout << "The game is using a " << game->getDice()->sides << "-sided dice" << std::endl;
    }
    void game(DiceGame* game, int diceRoll) {
    numberOfTurns += 1;
    std::cout << "Rolled a " << diceRoll << std::endl;
}

    void gameDidEnd(DiceGame* game) {
    std::cout << "The game lasted for " << numberOfTurns << " turns" << std::endl;
}
};


int main() {
    DiceGameDelegate *d = new DiceGameTracker();
    std::optional<DiceGameDelegate*> tracker = std::optional<DiceGameDelegate*>{d};
    SnakesAndLadders* game = new SnakesAndLadders();
    game->delegate = tracker;
    game->play();

    return 0;
    

}