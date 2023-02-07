
int switchMe(int input){
    int counter = 0;

    switch (input) {
        case 2: 
        counter = 100;
        case 3: 
        counter -= 23;
        default:
        counter = 42;
    }
    return counter;
}

int main(){
    int res = switchMe(2);
    return 0;
}