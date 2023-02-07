
 #include <iostream>
 #include <string>
 
 using namespace std;
 
 struct MyMain
 {
   static void main(){
     string x = "world";
     bool tmp = stringEqual(x);
     cout << tmp << endl;
     tmp = stringEqual("hello");
     cout << tmp << endl;
     tmp = stringNotEqual(x);
     cout << tmp << endl;
     tmp = stringNotEqual("hello");
     cout << tmp << endl;
     tmp = stringLarger(x);
     cout << tmp << endl;
     tmp = stringLarger("hello");
     cout << tmp << endl;
     tmp = stringSmaller("hello");
     cout << tmp << endl;
     tmp = stringSmaller(x);
     cout << tmp << endl;
     tmp = stringLargerOrEqual(x);
     cout << tmp << endl;
     tmp = stringLargerOrEqual("hello");
     cout << tmp << endl;
     tmp = stringSmallerOrEqual(x);
     cout << tmp << endl;
     tmp = stringSmallerOrEqual("hello");
     cout << tmp << endl;
   }
 
   static bool stringEqual(string x){
     bool tmp = x == "world";
     return tmp;
   }
 
   static bool stringNotEqual(string x){
     bool tmp = x != "world";
     return tmp;
   }
 
   static bool stringLarger(string x){
     bool tmp = x > "world";
     return tmp;
   }
 
   static bool stringSmaller(string x){
     bool tmp = x < "world";
     return tmp;
   }
 
   static bool stringLargerOrEqual(string x){
     bool tmp = x >= "world";
     return tmp;
   }
 
   static bool stringSmallerOrEqual(string x){
     bool tmp = x <= "world";
     return tmp;
   }
 };
 
 int main(){
   MyMain::main();
   return 0;
 }