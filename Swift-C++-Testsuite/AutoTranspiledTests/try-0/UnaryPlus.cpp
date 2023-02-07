
struct MyMain
{
    static int main() 
    {
        return unaryPlus(x: -1);
    }

    // Documentation states the following
    // The unary plus operator (+) simply returns the value it operates on, without any change
    static int unaryPlus (int x)
    {
        int a = x;
        int b = +a;
        return b;
    }

};

int main()
{
    return MyMain::main();
}