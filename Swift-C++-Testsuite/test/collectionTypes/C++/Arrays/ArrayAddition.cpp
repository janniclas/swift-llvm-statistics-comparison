#include <vector>
int main()
{   
    std::vector<int> a = { 0, 0, 0 };
    std::vector<int> b = { 2, 3, 4 };
    std::vector<int> c;
    c.insert(c.begin(), a.begin(), a.end());
    c.insert(c.begin() + a.size(), b.begin(), b.end());
}
