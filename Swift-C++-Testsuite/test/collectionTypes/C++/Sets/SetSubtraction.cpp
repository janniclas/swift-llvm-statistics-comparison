#include <set>
#include <algorithm>


int main() {
        std::set<int> oddDigits = {1, 3, 5, 7, 9};  // Create a set of odd digits
        std::set<int> singleDigitPrimeNumbers = {2, 3, 5, 7};  // Create a set of single-digit prime numbers

        std::set<int> difference;  // Create an empty set to store the difference
        std::set_difference(oddDigits.begin(), oddDigits.end(), singleDigitPrimeNumbers.begin(), singleDigitPrimeNumbers.end(), std::inserter(difference, difference.begin()));  // Compute the difference between the sets
}
