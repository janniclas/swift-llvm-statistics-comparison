
#include <iostream>
using namespace std;

class MyMain{
    public:
    static void main(){
        int x = 3;
        repetitions(x);
    }
    static int repetitions(int x){
        for (int i = 0; i < x; ++i){
            cout << "Hello!" << endl;
        }
    }
};

int main(){
    MyMain::main();
    return 0;
}