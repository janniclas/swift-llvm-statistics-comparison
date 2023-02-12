#include <vector>
int main()
{   
    std::vector<int> a = { 0, 0, 0 };
    std::vector<int> b = { 2, 3, 4 };
    std::vector<int> c(a.size() + b.size());
    std::merge(a.begin(), a.end(), b.begin(), b.end(), c.begin());
}
