#include <algorithm>
#include <set>

int main() {
        std::set<int> oddDigits = {1, 3, 5, 7, 9};  // Create a set of odd digits
        std::set<int> evenDigits = {0, 2, 4, 6, 8};  // Create a set of even digits

        bool isSuperset = std::includes(oddDigits.begin(), oddDigits.end(), evenDigits.begin(), evenDigits.end());  // Check if oddDigits is a superset of evenDigits
}
