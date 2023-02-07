 
#include <set> 

int main(){
    std::set<int> oddDigits={1,3,5,7,9};
    std::set<int> evenDigits={0,2,4,6,8};

    oddDigits.find() == evenDigits.end();
    return 0;
}