#include <string>

int main() {
    std::string greeting = "Guten Tag!";
    char beginning = greeting[0];
    char beginningAlt = *greeting.begin();

    char end = *greeting.end();
    char endAlt = greeting[greeting.length() -1];

    std::string::iterator offset7 = greeting.begin() + 7;
    char offsetChar = *offset7;

    for ( std::string::iterator it=greeting.begin(); it!=greeting.end(); ++it) {
        char curr = *it;
    }

    greeting.insert(greeting.length()-1, "!");

    greeting.erase(greeting.length()-2, greeting.length()-1);
}
