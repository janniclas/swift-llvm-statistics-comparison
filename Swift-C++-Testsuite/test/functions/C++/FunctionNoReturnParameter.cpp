

void paramNoReturn(int x)
{
    int a = 5;
    int b = 10;
    int c = a + b + x;
}


int main() 
{
    paramNoReturn(42);
    return 0;
}