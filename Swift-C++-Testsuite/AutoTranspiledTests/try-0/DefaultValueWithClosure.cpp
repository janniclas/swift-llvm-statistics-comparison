
#include <iostream>
using namespace std;

class Chessboard{
private:
    bool boardColors[64];
public:
    Chessboard(){
        bool isBlack = false;
        for (int row=0; row<8; row++){
            for (int col=0; col<8; col++){
                boardColors[(row*8)+col]=isBlack;
                isBlack=!isBlack;
            }
            isBlack=!isBlack;
        }
    }
    bool squareIsBlackAt(int row, int col){
        return boardColors[(row*8)+col];
    }
};

int main(){
    Chessboard board;
    cout<<board.squareIsBlackAt(0,1)<<endl;
    cout<<board.squareIsBlackAt(7,7)<<endl;
}