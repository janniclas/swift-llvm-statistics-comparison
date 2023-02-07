 
#include <iostream>

int switchMe(std::pair<int,int> input) {
    int counter = 0;
    int max = 7;
    switch(input){
        case(std::pair<int,int>(let x, let y):
                counter = 100;
    // Fallthrough is implied in C++
        case(std::pair<int, int>(0, let y):
            counter = -y;
        case(let (x,y):
            counter = -x
        default:
            counter = 42;
    }
    return counter;
}

int main(){
    std::pair<int,int> input = std::pair<int,int>(2,3);
    int res = switchMe(input);
    std::out << res << std::endl;
    return 0;
}