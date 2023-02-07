
int switchMe(int input_1, int input_2){
    int counter = 0;
    int max = 7;
    if (input_1 == 0 && input_2 != 0){
        counter = - input_2; 
    }else if(input_1 != 0 && input_2 == 0){
        counter = -input_1; 
    }else if (input_1 != 0 && input_2 != 0){
        counter = -input_1;
    }else{
        counter = 42;
    }
    return counter;
}

int main(){
    int res = switchMe(2,3);
    return 0;
}