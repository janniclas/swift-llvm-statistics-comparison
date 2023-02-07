
 #include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

int main()
{
        vector<int> numbers = { 42, 1, 47, 22, 23, 24 };
        sort(numbers.begin(), numbers.end(), greater<int>());
        return 0;
}