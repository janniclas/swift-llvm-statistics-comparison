 
 
 struct MyMain {
    static void main() {
        int someThrowingFunction() throw(); {
            //...
            return 42;
        }

        int x = try? someThrowingFunction();

        int y = 0;
        try {
            y = someThrowingFunction();
        }
        catch(...) {
            y = NULL;
        }
    }
};