
 #include<iostream>
 using namespace std;

 class Bank {
 public:
     static int coinsInBank = 10000;
     static int distribute(int numberOfCoinsRequested) {
         int numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank);
         coinsInBank -= numberOfCoinsToVend;
         return numberOfCoinsToVend;
     }

     static void receive(int coins) {
         coinsInBank += coins;
     }
};

class Player {
    private:
        int coinsInPurse;
    public:
        Player(int coins){
            coinsInPurse = Bank::distribute(coins);
        }

        void win(int coins) {
            coinsInPurse += Bank::distribute(coins);
        }

        ~Player() {
            Bank::receive(coinsInPurse);
        }
};

// Main function
int main() {
    Player *playerOne = new Player(100);
    playerOne->win(2000);
    cout << "PlayerOne won 2000 coins & now has " << playerOne->coinsInPurse << "coins" << endl; 
    cout << "The bank now only has" << Bank::coinsInBank << "coins left" << endl;
    playerOne = nullptr;
    cout << "PlayerOne has left the game" << endl;
    cout << "The bank now has " << Bank::coinsInBank << "coins" << endl;
    return 0;
}