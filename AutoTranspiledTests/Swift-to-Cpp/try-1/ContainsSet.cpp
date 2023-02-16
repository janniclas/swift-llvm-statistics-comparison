
#include <iostream>
#include<set>

int main()
{
    std::set<int> numberSet;
    numberSet.insert(42);
    bool contains = numberSet.find(42) != numberSet.end();
    bool notContained = numberSet.find(44) == numberSet.end();
    return 0;
}