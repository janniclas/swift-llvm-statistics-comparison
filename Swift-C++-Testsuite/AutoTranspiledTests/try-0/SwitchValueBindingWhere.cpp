
 #include <iostream>

 struct MyMain{

    static int main(){
        int res = switchMe((2, 3));
    }

    static int switchMe(std::pair<int, int> input) {
        int counter = 0;
        int max = 7;
        switch (input.first) {
            case x:
                counter = x;
            case 0:
                counter = -y;
            default: 
                if (x == y){
                    counter = -x;
                }
                else {
                    counter = -1;
                }
        }
        return counter;
    }
 };