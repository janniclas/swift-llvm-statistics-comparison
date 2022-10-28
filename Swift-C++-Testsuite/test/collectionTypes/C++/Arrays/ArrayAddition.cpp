#include <vector>
int main()
{   
    std::vector<int> a = { 0, 0, 0 };
    std::vector<int> b = { 2, 3, 4 };
    std::vector<int> c;
    c.insert(c.begin(), a.begin(), a.end());
    c.insert(c.begin() + a.size(), b.begin(), b.end());
}

// {   
//     const size_t sizeA = 5;
//     const size_t sizeB = 5;
//     std::array<int, sizeA> a = { 16, 2, 77, 40, 12071 };
//     std::array<int, sizeB> b = { 42, 1, 2, 3, 4 };
//     std::array<int, sizeA+sizeB> c;
//     std::copy(a.begin(), a.end(), c.begin());
//     std::copy(b.begin(), b.end(), c.begin() + sizeA);
// }
//var threeDoubles = Array(repeating: 0.0, count: 3)
//var fourDoubles = [2.0, 1.3, 2.2, 4.2]
//var sevenDoubles = threeDoubles + fourDoubles
