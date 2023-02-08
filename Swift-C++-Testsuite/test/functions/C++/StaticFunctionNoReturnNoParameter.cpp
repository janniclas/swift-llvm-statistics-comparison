
struct MyMain {
 
  static void noParamNoReturn() {
    int a = 5;
    int b = 10;
    int c = a + b;
  }
};
 
int main() {
 MyMain::noParamNoReturn();
 
 return 0;
}