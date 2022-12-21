#include <set>
int main()
{
    std::set<int> numberSet;
    numberSet.insert(42);
    bool contains = numberSet.contains(42);
    bool notContained = numberSet.contains(44);
}
