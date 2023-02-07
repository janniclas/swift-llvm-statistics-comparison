

#include <iostream>
#include <stack>
using namespace std;

struct MyMain
{
    static void main()
    {
        stack<string> stackOfStrings;
        stackOfStrings.push("uno");
        stackOfStrings.push("dos");
        stackOfStrings.push("tres");
        stackOfStrings.push("cuatro");
        stack<int> stackOfNumbers;
        stackOfNumbers.push(1);
        stackOfNumbers.push(2);
        stackOfNumbers.push(3);
        stackOfNumbers.push(4);

        if (!stackOfStrings.empty())
        {
            cout << "The top item on the stack is " << stackOfStrings.top() << endl;
        }
        if (!stackOfNumbers.empty())
        {
            cout << "The top item on the stack is " << stackOfNumbers.top() << endl;
        }
    }
};
int main(){
  MyMain::main();
}