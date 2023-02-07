
#include<iostream> 
#include<vector> 
#include <algorithm>
using namespace std; 

int main() 
{ 
    vector<int> numbers {42, 1, 47, 22, 23, 24}; 
    sort(numbers.rbegin(), numbers.rend()); 
    for (auto& num : numbers) 
        cout << num << " ";
    return 0;
}