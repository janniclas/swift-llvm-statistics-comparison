
#include <iostream>
#include <map>
 
int main() {
    std::map<int, int> namesOfIntegers = {{5, 32}, {4, 42}};
    namesOfIntegers.erase(1);
 
    return 0;
}