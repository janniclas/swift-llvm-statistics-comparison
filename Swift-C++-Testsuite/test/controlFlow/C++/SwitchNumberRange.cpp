
int switchMe(int input){
    int counter = 0;
    int max = 7;
    switch (input) {
        case 1:
        case 2:
        case 3:
        case 4: 
        counter = max;
        break;
        case 0: 
        counter -= -max;
        break;
        default:
        counter = 42;
    }
    return counter;
}

int main(){
    int res = switchMe(2);
    return 0;
}