
#include <iostream>
#include <set>

using namespace std;
 
int main(){
    set <int> oddDigits = {1, 3, 5, 7, 9};
    set<int> singleDigitPrimeNumbers = {2, 3, 5, 7};
 
    set_symmetric_difference(oddDigits.begin(), oddDigits.end(), 
                  singleDigitPrimeNumbers.begin(), 
                  singleDigitPrimeNumbers.end(), 
                  inserter(oddDigits, oddDigits.begin())); 
    cout << "Output Set - ";
    for (int i : oddDigits) 
        cout << i << ' ';
    return 0; 
}