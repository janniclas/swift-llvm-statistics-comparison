

#include <bits/stdc++.h>
 
using namespace std;
 
int main(){
    map<int, string> digitNames;
    digitNames[0] = "Zero"; digitNames[1] = "One"; digitNames[2] = "Two";
    digitNames[3] = "Three"; digitNames[4] = "Four";
    digitNames[5] = "Five"; digitNames[6] = "Six"; digitNames[7] = "Seven";
    digitNames[8] = "Eight"; digitNames[9] = "Nine";

    vector<int> numbers = {16, 58, 510};
    vector<string> strings;
 
    for (int number: numbers){
        string output;
        int n = number;

        while (n > 0){
            output = digitNames[n % 10] + output;
            n /= 10;
        }
        strings.push_back(output);
    }
    return 0;
}