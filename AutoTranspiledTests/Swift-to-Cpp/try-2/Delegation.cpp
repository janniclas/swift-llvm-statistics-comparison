
class MyMain {
public:
    static void main() {
        DiceGameTracker tracker = DiceGameTracker();
        SnakesAndLadders game = SnakesAndLadders();
        game.delegate = tracker;
        game.play();
    }
};

class DiceGameTracker : public DiceGameDelegate {
public:
    int numberOfTurns = 0;

    void gameDidStart(DiceGame game) override {
        numberOfTurns = 0;
        if (dynamic_cast<SnakesAndLadders>(game) != nullptr) {
            cout << "Started a new game of Snakes and Ladders" << endl;
        }
        cout << "The game is using a " << game.dice.sides << "-sided dice" << endl;
    }

    void game(DiceGame game, int diceRoll) override {
        numberOfTurns += 1;
        cout << "Rolled a " << diceRoll << endl;
    }

    void gameDidEnd(DiceGame game) override {
        cout << "The game lasted for " << numberOfTurns << " turns" << endl;
    }
};

class SnakesAndLadders : public DiceGame {
public:
    int finalSquare = 25;
    Dice dice = Dice(sides: 6, generator: LinearCongruentialGenerator());
    int square = 0;
    vector<int> board;

    SnakesAndLadders() { 
        board = vector<int>(finalSquare + 1, 0);
        board[03] = +08;
        board[06] = +11;
        board[09] = +09;
        board[10] = +02;
        board[14] = -10;
        board[19] = -11;
        board[22] = -02;
        board[24] = -08;
    }

    DiceGameDelegate *delegate; 

    void play() {
        square = 0;
        delegate->gameDidStart(this);
        while (square != finalSquare) {
            int diceRoll = dice.roll();
            delegate->game(this, diceRoll);
            switch (square + diceRoll) {
            case finalSquare:
                break;
            case int newSquare :
                if (newSquare > finalSquare) {
                    continue;
                }
                square += diceRoll;
                square += board[square];
                break;
            }
        }
        delegate->gameDidEnd(this);
    }
};

class Dice {
public:
    int sides;
    RandomNumberGenerator generator;

    Dice(sides, generator) {
        this.sides = sides;
        this.generator = generator;
    }

    int roll() {
        return int(generator.random() * double(sides)) + 1;
    }
};

class LinearCongruentialGenerator : public RandomNumberGenerator {
public:
    double lastRandom = 42.0;
    double m = 139968.0;
    double a = 3877.0;
    double c = 29573.0;

    double random() override {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy: m));
        return lastRandom / m;
    }
};

class DiceGame {
public:
    virtual Dice dice;
    virtual void play();
};

class DiceGameDelegate {
public:
    virtual void gameDidStart(DiceGame game);
    virtual void game(DiceGame game, int diceRoll);
    virtual void gameDidEnd(DiceGame game);
};