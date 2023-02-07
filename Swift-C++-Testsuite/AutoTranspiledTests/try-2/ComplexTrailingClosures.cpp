
 #include 
using namespace std;

int main() {
    
	map<int, string> digitNames;
	digitNames[0] = "Zero";
	digitNames[1] = "One";
	digitNames[2] = "Two";
	digitNames[3] = "Three";
	digitNames[4] = "Four";
	digitNames[5] = "Five";
	digitNames[6] = "Six";
	digitNames[7] = "Seven";
	digitNames[8] = "Eight";
	digitNames[9] = "Nine";
   
   	vector<int> numbers;
   	numbers.push_back(16);
   	numbers.push_back(58);
   	numbers.push_back(510);
   
   	vector<string> strings;
   	for (int n : numbers) {
   		int number = n;
   		string output = "";
   		while (number > 0) {
   			output = digitNames.at(number % 10) + output;
   			number /= 10;
   		}
   		strings.push_back(output);
   	}
   	return 0;
}