
#include <iostream>
using namespace std;

struct MyMain 
{
    static double convert(double number, char unit)
    {
        double converted = 0.0;
        switch(unit)
        {
            case 'K':
                converted = number * 1000.0;
                break;
            case 'M':
                converted = number;
                break;
            case 'C':
                converted = number / 100.0;
                break;
            case 'M':
                converted = number / 1000.0;
                break;
            case 'F':
                converted = number / 3.28084;
                break;
            default:
                cout << "unexpected unit" << endl;
                break;
        }
        return converted;
    }

    static void main()
    {
        double oneInch = convert(25.4, 'M');
        cout << "One inch is " << oneInch << " meters" << endl;
        double threeFeet = convert(3.0, 'F');
        cout << "Three feet is " << threeFeet << " meters" << endl;
    }
};

int main ()
{
    MyMain::main();
    return 0;
}