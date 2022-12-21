#include <set>

int main() {
    std::set<int> oddDigits = {1, 3, 5, 7, 9};  // Create a set of odd digits
    std::set<int> evenDigits = {0, 2, 4, 6, 8};  // Create a set of even digits

    bool disjoint = std::none_of(oddDigits.begin(), oddDigits.end(), [&evenDigits](int x) { return evenDigits.count(x); });  // Check if the sets have no elements in common
}
