#include <set>
#include <algorithm>

int main() {
        std::set<int> oddDigits = {1, 3, 5, 7, 9};  // Create a set of odd digits
        std::set<int> evenDigits = {0, 2, 4, 6, 8};  // Create a set of even digits

        bool isSubset = std::includes(evenDigits.begin(), evenDigits.end(), oddDigits.begin(), oddDigits.end());  // Check if oddDigits is a subset of evenDigits
    }
