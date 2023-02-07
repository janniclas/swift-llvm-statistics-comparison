
#include<iostream>
#include<algorithm>
#include<map>
#include<vector>

std::map<int, std::string> digitNames = {
            {0: "Zero"}, {1: "One"}, {2: "Two"}, {3: "Three"}, {4: "Four"},
            {5: "Five"}, {6: "Six"}, {7: "Seven"}, {8: "Eight"}, {9: "Nine"},
        };
std::vector<int> numbers = {16, 58, 510};


int main() {
        
        std::vector<std::string> strings;
        std::transform(numbers.begin(), numbers.end(),  strings.begin(), [] (int number) -> std::string {
            std::string output = "";
            int tempNumber = number;
            do {
                output = digitNames[number % 10] + output;
                number /= 10;
            } while (number > 0);

            return output;
            });



    return 0;
}