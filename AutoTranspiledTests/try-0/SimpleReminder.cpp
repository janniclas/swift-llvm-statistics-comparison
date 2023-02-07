
struct MyMain {

static int main(){
    int result = simpleReminder(43);
    std::cout << result;
    return result;
}

// We need to store, return, or use the result of the reminder to keep
// the compiler to remove it during optimization.
static int simpleReminder(int x){
    int a = x;
    int b = a % 2;
    return b;
}
};

int main(){
    return MyMain::main();
}