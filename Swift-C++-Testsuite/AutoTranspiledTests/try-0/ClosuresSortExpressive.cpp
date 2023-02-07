
#include      <vector>
#include      <algorithm>
#include      <iostream>

using namespace std;

bool backward(int s1, int s2) {
    return s1 > s2;
}

int main(){
    vector<int> numbers = {42, 1, 47, 22, 23, 24};
    sort(numbers.begin(), numbers.end(), backward);
    return 0;
}