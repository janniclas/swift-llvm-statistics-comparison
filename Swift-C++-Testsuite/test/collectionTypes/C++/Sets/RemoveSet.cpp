// @main
// struct MyMain {

//     static func main() {
//         var numberSet = Set<Int>()
//         numberSet.insert(42)
//         numberSet.remove(42)
//     }
// }
#include <set>
int main()
{
    std::set<int> numberSet;
    numberSet.insert(42);
    numberSet.erase(42);
}
