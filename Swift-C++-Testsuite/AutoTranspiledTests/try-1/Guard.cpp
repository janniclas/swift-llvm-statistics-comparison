 
 #include <iostream>
#include <string>
#include <map>

using namespace std;

void greet(map<string, string> person) {
	if (person.find("name") == person.end()){
		return;
	}
	string name = person["name"];
	cout << "Hello " << name << "!" << endl;
	
	if (person.find("location") == person.end()) {
		cout << "I hope the weather is nice near you." << endl;
		return;
	}
	string location = person["location"];
	cout << "I hope the weather is nice in " << location <<"." << endl;
}

int main() 
{
	map<string, string> personOne;
	personOne["name"] = "John";

	greet(personOne);

	map<string, string> personTwo;
	personTwo["name"] = "Jane",
	personTwo["location"] = "Cupertino";

	greet(personTwo);
	
	return 0;
}