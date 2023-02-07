
#include <iostream>
#include <set>
using namespace std;

int main(){
    set<int> oddDigits{1, 3, 5, 7, 9}; 
    set<int> evenDigits{0, 2, 4, 6, 8};
    
    bool isSubset = includes(evenDigits.begin(), evenDigits.end(), 
                            oddDigits.begin(), oddDigits.end());
    cout << isSubset << endl;
    
    return 0;
}