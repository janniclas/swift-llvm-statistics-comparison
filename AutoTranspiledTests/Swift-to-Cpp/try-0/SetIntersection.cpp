
 #include <iostream>
#include <set>

using namespace std;

int main () {
    set<int> oddDigits { 1, 3, 5, 7, 9 };
    set<int> evenDigits { 0, 2, 4, 6, 8 };
    
    set<int> intersection; 
    set_intersection(oddDigits.begin(), oddDigits.end(), evenDigits.begin(), evenDigits.end(), inserter(intersection, intersection.begin()));

    return 0;
}