
 struct MyMain {
     static void main() {
        int someThrowingFunction() {
          // ...
          return 42;
        }

        int x = someThrowingFunction();

        int y;
        try {
            y = someThrowingFunction();
        }
        catch {
            y = -1;
        }
     }
 };
 
 int main() {
    MyMain::main();
    return 0;
 }