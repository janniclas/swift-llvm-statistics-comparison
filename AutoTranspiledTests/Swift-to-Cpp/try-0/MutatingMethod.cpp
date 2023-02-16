
enum OnOffSwitch : char {
    off,
    on
};

void toggle(OnOffSwitch& lightSwitch) {
    switch (lightSwitch) {
    case OnOffSwitch::off : 
        lightSwitch = OnOffSwitch::on;
        break;
    case OnOffSwitch::on : 
        lightSwitch = OnOffSwitch::off;
        break;
    default : 
        break; 
    }
}

int main() {
    OnOffSwitch lightSwitch = OnOffSwitch::off;
    toggle(lightSwitch); 
    return 0;
}