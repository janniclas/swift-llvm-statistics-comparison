

#include <iostream>
#include <ctime>

class DiceGameTracker {
private:
    int numberOfTurns = 0;
public:
    void gameDidStart(DiceGame* game);
    void game(DiceGame* game, int diceRoll);
    void gameDidEnd(DiceGame* game);
};

class SnakesAndLadders : public DiceGame {
private:
    const int finalSquare = 25;
    Dice* dice;
    int square = 0;
    int board[26];
public:
    SnakesAndLadders() {
        dice = new Dice(6, LinearCongruentialGenerator());
        std::fill_n(board, 26, 0);
        board[03] = +08;
        board[06] = +11;
        board[09] = +09;
        board[10] = +02;
        board[14] = -10;
        board[19] = -11;
        board[22] = -02;
        board[24] = -08;
    }
    Dice* getDice() {
        return dice;
    }
    void play();
};

class Dice {
private:
    int sides;
    RandomNumberGenerator* generator;
public:
    Dice(int sides, RandomNumberGenerator* generator) {
        this->sides = sides;
        this->generator = generator;
    }
    int roll() {
        return (int)(generator->random() * sides) + 1;
    }
};

class RandomNumberGenerator {
public:
    virtual double random() = 0;
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

void DiceGameTracker::gameDidStart(DiceGame* game) {
    numberOfTurns = 0;
    if (dynamic_cast<SnakesAndLadders*>(game) != NULL) {
        std::cout << "Started a new game of Snakes and Ladders" << std::endl;
    }    
    std::cout << "The game is using a " << game->getDice()->sides << "-sided dice" << std::endl;
}

void DiceGameTracker::game(DiceGame* game, int diceRoll) {
    numberOfTurns += 1;
    std::cout << "Rolled a " << diceRoll << std::endl;
}

void DiceGameTracker::gameDidEnd(DiceGame* game) {
    std::cout << "The game lasted for " << numberOfTurns << " turns" << std::endl;
}

void SnakesAndLadders::play() {
    square = 0;
    DiceGameDelegate* delegate;
    delegate->gameDidStart(this);
    gameLoop: while(square != finalSquare) {
        int diceRoll;
        diceRoll = dice->roll();
        delegate->game(this, diceRoll);
        switch(square + diceRoll) {
            case finalSquare: {
                break gameLoop;
            }
            case int newSquare if(newSquare > finalSquare): {
                continue gameLoop;
            }
            default: {
                square += diceRoll;
                square += board[square];
            }
        }
    }
    delegate->gameDidEnd(this);
}

int main() {
    
    DiceGameTracker* tracker = new DiceGameTracker();
    SnakesAndLadders* game = new SnakesAndLadders();
    game->delegate = tracker;
    game->play();

    return 0;
    

}