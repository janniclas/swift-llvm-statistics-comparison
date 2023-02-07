 
#include<bits/stdc++.h>
using namespace std;

struct MyMain
{
    static void main()
    {
        vector<int> customersInLine = {1, 2, 3, 4, 5, 6, 42};
        vector<function<int()> > customerProviders;

		// Optimization - copy values if they are not mutated by a closure
        void collectProvider(const function<int()>& customerProvider)
        {
            customerProviders.push_back(customerProvider);
        }

        collectProvider([&](){return customersInLine.erase(customersInLine.begin());});
        collectProvider([&](){return customersInLine.erase(customersInLine.begin());});

        for(auto& provider : customerProviders)
        {
            int result = provider();
        }
    }
};

int main()
{
MyMain::main();
return 0;
}