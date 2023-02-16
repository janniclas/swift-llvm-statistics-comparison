 
#include <iostream>
#include <vector>

using namespace std;

double arithmeticMean(vector<double> numbers) {
    double total = 0;
    for (int i = 0; i < numbers.size(); i++) {
        total += numbers[i];
    }
    return total / numbers.size();
}

int main() {
    vector<double> values = {3, 8.25, 18.75};
    double res = arithmeticMean(values);
    cout << res << endl;
    
    return 0;
}