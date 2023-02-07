

class HTMLElement {
public:
    string name;
    string *text;

    std::function<string(void)> asHTML;

    HTMLElement(string name, string *text) {
        this->name = name;
        this->text = text;
        asHTML = [this] {
            if (this->text)
                return "<" + this->name + ">" + *(this->text) + "</" + this->name + ">";
            else
                return "<" + this->name + "/>";
        };
    }

    ~HTMLElement() {
        cout << name << "is being deinitialized\n";
    }
};

int main() {
    HTMLElement elem = HTMLElement("div");
    string hele = elem.asHTML();
}