
struct MyMain {
  static void main(){
    greet(person={"name" : "John"});
	// Prints "Hello John!"
    // Prints "I hope the weather is nice near you."
    greet(person={"name" : "Jane", "location" : "Cupertino"}); 
  }
  static void greet(map<string,string> person) {
    if(!person.count("name")) {
      return;
    }
    cout << "Hello " << person["name"] << "!" << endl;
    if(!person.count("location")) {
      cout << "I hope the weather is nice near you." << endl;
      return;
    }
    cout << "I hope the weather is nice in " << person["location"] << "." << endl; 
  } 	
};