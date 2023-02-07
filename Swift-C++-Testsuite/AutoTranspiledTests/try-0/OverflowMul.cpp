
int MyMain() 
{
    // This call would crash with a normal mul.
    // returns -9223372036854775808
    int a = mulWithOverflow(INT_MAX);

    // The & sign turns an mulition to an mulition without overflow
    int mulWithOverflow(int x) 
    {
        int tmp = x &* 2;
        return tmp;
    }
    
    return 0;
}