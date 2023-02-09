
#include <iostream>
#include <algorithm>



class Bank {
    public:
        static int coinsInBank;
        static int distribute(int numberOfCoinsRequested);
        static void receive(int coins);
};

int Bank::distribute(int numberOfCoinsRequested) {
    int numberOfCoinsToVend = std::min(numberOfCoinsRequested, coinsInBank);
    coinsInBank -= numberOfCoinsToVend;
    return numberOfCoinsToVend;
}

void Bank::receive(int coins) {
    coinsInBank += coins;
}

int Bank::coinsInBank = 10000;
class Player {
    public:
        int coinsInPurse;
        Player(int coins);
        void win(int coins);
        ~Player();
};

Player::Player(int coins) {
    coinsInPurse = Bank::distribute(coins);
}

void Player::win(int coins) {
    coinsInPurse += Bank::distribute(coins);
}

Player::~Player() {
    Bank::receive(coinsInPurse);
}
int main() {
    Player *playerOne{nullptr};
    playerOne = new Player(100);
    playerOne->win(2000);
    std::cout << "PlayerOne won 2000 coins & now has " << playerOne->coinsInPurse  << " coins" << std::endl;
    std::cout << "The bank now only has " << Bank::coinsInBank << " coins left" << std::endl;
    delete playerOne;
    std::cout << "PlayerOne has left the game" << std::endl;
    std::cout << "The bank now has " << Bank::coinsInBank << " coins" << std::endl;
    return 0;
}