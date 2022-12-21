#include <set>
#include <algorithm>

int main() {
        std::set<int> oddDigits = {1, 3, 5, 7, 9};  // Create a set of odd digits
        std::set<int> evenDigits = {0, 2, 4, 6, 8};  // Create a set of even digits

        std::set<int> unionSet;  // Create an empty set to store the union
        std::set_union(oddDigits.begin(), oddDigits.end(), evenDigits.begin(), evenDigits.end(), std::inserter(unionSet, unionSet.begin()));  // Compute the union of the sets
}
