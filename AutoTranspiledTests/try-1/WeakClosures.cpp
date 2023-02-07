
   
 class HTMLElement {
 
 public:
     std::string name;
     std::string text;
     
     std::function<std::string()> asHTML;
     
     void init(std::string name, std::string text){
        this->name = name;
        this->text = text;
        auto f = [this] () -> std::string {
            if(!text.empty()){
                return "<" + this->name + ">" + this->text + "<\\" + this->name + ">";
            } else {
                return "<" + this->name + " />";
            }
        };
     }

    ~HTMLElement() {
        std::cout << name << " is being deinitialized" << std::endl;
    }
 };

 int main(){
     HTMLElement elem = HTMLElement();
     elem.init("div", "");
     std::string hele = elem.asHTML(); 
     return 0;
 }