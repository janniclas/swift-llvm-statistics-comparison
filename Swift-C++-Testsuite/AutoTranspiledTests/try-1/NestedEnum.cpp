 
#include <iostream>
#include <vector>

class MyMain {
    public:
        static void main()
        {
            void printIntegerKinds(std::vector<int> numbers) 
            { 
                for(int number : numbers) 
                { 
                    switch (number.kind())
                    {
                        case negative: 
                            std::cout << "-";
                            break;
                        case zero:
                            std::cout <<"0"; 
                            break;
                        case positive:
                            std::cout << "+";
                            break;
                    } 
                } 
                std::cout << std::endl;
            } 
            
            printIntegerKinds({3, 19, -27, 0, -6, 0, 7});
        }

    private: 
        enum Kind {negative, zero, positive};
    
        Kind kind() {
            switch (this)
            {
                case 0: 
                    return zero;
                case (let x) > 0: 
                    return positive;
                default:
                    return negative;
            }
        } 
}; 

int main() { 
    MyMain::main(); 
    return 0; 
}