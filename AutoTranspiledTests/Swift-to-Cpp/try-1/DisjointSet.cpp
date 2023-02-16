
#include <iostream>
#include <set> 
 
int main() 
{ 
    std::set<int> oddDigits; 
    oddDigits.insert(1); 
    oddDigits.insert(3); 
    oddDigits.insert(5); 
    oddDigits.insert(7); 
    oddDigits.insert(9); 
  
    std::set<int> evenDigits; 
    evenDigits.insert(0); 
    evenDigits.insert(2); 
    evenDigits.insert(4); 
    evenDigits.insert(6); 
    evenDigits.insert(8); 
  
    std::cout << std::boolalpha << std::endl; 
  
    std::cout << "Are oddDigits and evenDigits disjoint? "; 
    std::cout << std::boolalpha << oddDigits.empty() && 
        (oddDigits.size() + evenDigits.size() == 
        oddDigits.size() + evenDigits.size()) 
              << std::endl; 
  
    return 0; 
}