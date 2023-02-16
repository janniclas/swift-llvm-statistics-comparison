

#include <iostream>
#include <string>
using namespace std;

struct Drawable {
    virtual string draw() = 0;
};

struct Line : Drawable {
    Drawable* elements[1000];
    int size;

    Line(Drawable *element){
        elements[0] = element;
        size = 1;
    }
    void add(Drawable *element){
        elements[size++] = element;
    }
    string draw(){
        string str = "";
        for (int i = 0; i < size; i++){
            str += elements[i]->draw();
        }
        return str;
    }    
};

struct Text : Drawable
{
    string content;
    Text(string content){
        this->content = content;
    }
    string draw(){
        return content;
    }
};

struct Space : Drawable {
    string draw(){
        return " ";
    }
};

struct Stars : Drawable {
    int length;
    Stars(int length){
        this->length = length;
    }
    string draw(){
        string stars = "";
        for (int i = 0; i < length; i++){
            stars += "*";
        }
        return stars;
    }
};

struct AllCaps : Drawable {
    Drawable *content;
    AllCaps(Drawable *content){
        this->content = content;
    }
    string draw(){
        return content->draw().substr(0, content->draw().length());
    }
};

Drawable*  makeGreeting(string name = "") {
    Drawable *stars1 = new Stars(3);
    Drawable *text = new Text("Hello ");
    Drawable *space = new Space();
    Drawable *nameText;
    if (name.length() != 0){
        nameText = new Text(name + "!");
    }
    else {
        nameText = new Text("World!");
    }
    Drawable *capsNameText = new AllCaps(nameText);
    Drawable *stars2 = new Stars(2);
    Line *final = new Line(stars1);
    final->add(text);
    final->add(space);
    final->add(capsNameText);
    final->add(stars2);
    return final;
    
}

int main(){
    Drawable *genericGreeting = makeGreeting();
    cout << genericGreeting->draw() << '\n';
    
    Drawable *personalGreeting = makeGreeting("Ravi Patel");
    cout << personalGreeting->draw() << '\n';
    return 0;
}