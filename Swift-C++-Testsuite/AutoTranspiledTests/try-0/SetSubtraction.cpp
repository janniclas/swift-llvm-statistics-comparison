
 #include <iostream>
 #include <set>

using namespace std;

struct MyMain {
    static void main() {
        set<int> oddDigits = {1, 3, 5, 7, 9};
        set<int> singleDigitPrimeNumbers = {2, 3, 5, 7};
        set<int> difference;

        set_difference(oddDigits.begin(), oddDigits.end(), singleDigitPrimeNumbers.begin(), singleDigitPrimeNumbers.end(), inserter(difference, difference.begin()));
    }
};

int main(){
    MyMain::main();
    return 0;
}