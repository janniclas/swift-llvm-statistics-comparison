
#include <iostream>
#include <string>

using namespace std;

int main() {
  string greeting = "Hello, world!";
  string::iterator index = find(greeting.begin(), greeting.end(), ',');
  string beginning = greeting.substr(0, index - greeting.begin());
  
  // Convert the result to a String for long-term storage.
  string newString = beginning;

  cout << "beginning = " << beginning << endl;
  cout << "newString = " << newString << endl;

  return 0;
}