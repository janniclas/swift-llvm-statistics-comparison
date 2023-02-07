
int compoundAssignment(int x){
    int a = x;
    a %= 2;
    return a;
}

int main(){
    compoundAssignment(43);
    return 0;
}