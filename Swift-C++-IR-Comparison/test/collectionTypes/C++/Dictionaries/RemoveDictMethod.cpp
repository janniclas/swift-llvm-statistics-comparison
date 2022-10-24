#include <map>
int main()
{
    std::map<int, int> namesOfIntegers = {{5,32}, {4,42}};
    auto it = namesOfIntegers.begin();
    it++;
    namesOfIntegers.erase(it);
}
