
#include <iostream>
#include <set>

using namespace std;

int main() {
    set<int> oddDigits = {1, 3, 5, 7, 9};
    set<int> evenDigits = {0, 2, 4, 6, 8};
  
    cout << boolalpha << oddDigits.find() != oddDigits.end()
    			&& evenDigits.find() != evenDigits.end()
				&& oddDigits.find() == evenDigits.end() << endl;
    return 0;
}