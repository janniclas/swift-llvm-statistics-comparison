
 #include <set> 
 
int main() 
{ 
    std::set<int> oddDigits = { 1, 3, 5, 7, 9 };
    std::set<int> singleDigitPrimeNumbers = { 2, 3, 5, 7 }; 
    std::set<int> symmetricDifference = oddDigits; 
  
    std::set_symmetric_difference(oddDigits.begin(), 
        oddDigits.end(), singleDigitPrimeNumbers.begin(), 
        singleDigitPrimeNumbers.end(),  
        std::inserter(symmetricDifference, 
                      symmetricDifference.begin())); 
  
    std ::cout << "Symmetric Difference is \n" ;
    for (auto it = symmetricDifference.begin(); 
             it != symmetricDifference.end(); it++) 
        cout << *it << " "; 
  
    std::cout << endl; 
  
    return 0; 
}