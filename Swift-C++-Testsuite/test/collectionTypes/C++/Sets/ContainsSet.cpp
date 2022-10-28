// @main
// struct MyMain {

//     static func main() {
//         var numberSet = Set<Int>()
//         numberSet.insert(42)
//         var contains = numberSet.contains(42)
//         var notContained = numberSet.contains(44)
//     }
// }
#include <set>
int main()
{
    std::set<int> numberSet;
    numberSet.insert(42);
    bool contains = numberSet.contains(42);
    bool notContained = numberSet.contains(44);
}
