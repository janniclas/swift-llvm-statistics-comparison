
#include <iostream>

int implicitReturn(int x){
    return x;
}

int main(){
    int x = 42;
    int identity = implicitReturn(x);
    std::cout << identity << std::endl;
    return 0;
}