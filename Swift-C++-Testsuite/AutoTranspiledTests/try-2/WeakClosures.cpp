
#include <iostream>
#include <string>
using namespace std;

class HTMLElement{
private:

    string name;
    string text;

    string asHTML(){
        if(text.size() > 0)
            return "<" + name + ">" + text + "</" + name + ">";
        else
            return "<" + name +  "/>";
    }

public:

    HTMLElement(string name, string text = "")
    : name(name), text(text)
    {}

    ~HTMLElement(){
        printf("%s is being deinitialized\n", name.c_str());
    }
};

int main(){

    HTMLElement *elem = new HTMLElement("div");
    string hele = elem->asHTML();

    /* Do stuff */

    delete elem;

    return 0;
}