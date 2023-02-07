#include<map>
#include <string>
#include <iostream> 

using namespace std;
    static void greet(map<string, string> person) {
        if(!person.count("name"))
        {
            return;
        }

        cout << "Hello" << person["name"] << "!";

        if(!person.count("location")) {
            cout << "I hope the weather is nice near you.";
            return;
        }

        cout << "I hope the weather is nice in " << person["location"] <<".";
    }
int main() {
    // map<string, string> singlePerson = ;
        greet({{"name", "John"}});
        // Prints "Hello John!"
        // Prints "I hope the weather is nice near you."
        greet({{"name", "Jane"}, {"location", "Cupertino"}});
    }

