
#include <iostream> 
#include <vector>
 
enum class Kind {
    NEGATIVE, 
    ZERO, 
    POSITIVE
};
 
class Int {
public:
    Int(int value) {
        this->value = value;
    }
 
    Kind kind() {
        switch (value) {
            case 0:
                return Kind::ZERO;
            case (int)::value > 0:
                return Kind::POSITIVE;
            default:
                return Kind::NEGATIVE;
        }
    }
 
private:
    int value;
};
 
void printIntegerKinds(std::vector<Int> &numbers) {
    std::vector<Int>::iterator it;
    for (it = numbers.begin(); it != numbers.end(); ++it) {
        switch((*it).kind()) {
            case Kind::NEGATIVE:
                std::cout << "- ";
                break;
            case Kind::ZERO:
                std::cout << "0 ";
                break;
            case Kind::POSITIVE:
                std::cout << "+ ";
                break;
            default:
                break;
        }
    } 
    std::cout << std::endl;
}
 
int main() {
    std::vector<Int> numbers;
    numbers.push_back(Int(3));
    numbers.push_back(Int(19));
    numbers.push_back(Int(-27));
    numbers.push_back(Int(0));
    numbers.push_back(Int(-6));
    numbers.push_back(Int(0));
    numbers.push_back(Int(7));
 
    printIntegerKinds(numbers);
 
    return 0;
}