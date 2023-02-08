
struct MyMain {
 
  static void paramNoReturn(int x, int y) {
    int a = 5;
    int b = 10;
    int c = a + b + x + y;
  }
};
 
int main() {
 MyMain::paramNoReturn(42, 44);
 
 return 0;
}