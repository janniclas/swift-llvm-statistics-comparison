
 #include <iostream>
#include <vector>

 int main() {
    std::vector<int> customersInLine = { 1, 2, 3, 4, 5, 6, 42 };
    auto customerProvider = [&customersInLine](){ 
        int next = customersInLine[0]; 
        customersInLine.erase(customersInLine.begin());
        return next; };
    auto next = customerProvider();
    std::cout << next;
    return 0;
}