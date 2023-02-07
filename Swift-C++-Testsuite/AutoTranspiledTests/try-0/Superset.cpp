
int main() {
    set<int> oddDigits {1,3,5,7,9};
    set<int> evenDigits {0,2,4,6,8};
    
    oddDigits.isSuperset(evenDigits);
    
    return 0;
}