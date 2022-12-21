
#include <set>
#include <vector>
#include <algorithm>


int main() {
        std::set<int> oddDigits = {1, 3, 5, 7, 9};  // Create a set of odd digits
        std::set<int> singleDigitPrimeNumbers = {2, 3, 5, 7};  // Create a set of single-digit prime numbers

        std::vector<int> symmetricDifference;  // Create an empty vector to store the symmetric difference
        std::set_symmetric_difference(oddDigits.begin(), oddDigits.end(), singleDigitPrimeNumbers.begin(), singleDigitPrimeNumbers.end(), std::back_inserter(symmetricDifference));  // Compute the symmetric difference of the two sets and store the result in symmetricDifference
}
