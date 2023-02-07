

#include <iostream> 
#include <vector> 

using namespace std; 

struct MyMain {
    
    static void initialise_customers(vector<int> &customersInLine) {
        customersInLine.push_back(1); 
        customersInLine.push_back(2); 
        customersInLine.push_back(3); 
        customersInLine.push_back(4); 
        customersInLine.push_back(5); 
        customersInLine.push_back(6); 
        customersInLine.push_back(42); 
    }

    static void collectProvider(function<int(void)> &customerProvider) {
        customerProviders.push_back(customerProvider); // copying value
    }

    static int main() {
        vector<int> customersInLine; 
        initialise_customers(customersInLine); 
        vector<function<int(void)>> customerProviders{};

        // the C++ closure equivalent of the Swift @autoclosure & @escaping
        collectProvider([customersInLine] () -> int { return customersInLine.erase(customersInLine.begin()); });
        collectProvider([customersInLine] () -> int { return customersInLine.erase(customersInLine.begin()); });

        // Note that there is no equivalent of Swift's automatic
        //  memory management in C++
        for (int i = 0; i < customerProviders.size(); i++) {
            int result = customerProviders[i](); 
        }
    }
};