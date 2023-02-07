

struct MyMain {

    static int main() {
        int res = switchMe(2, 3);
        return 0;
    }

    static int switchMe(int x, int y) {
        int counter = 0;
        int max = 7;
        switch(x)
        {
            case(x):
                counter = 100;
            // fallthrough
            case 0:
                counter = -y;
            case(x):
                counter = -x;
            default:
                counter = 42;
        }
        return counter;
    }
};

int main(){
    MyMain::main();
    return 0;
}