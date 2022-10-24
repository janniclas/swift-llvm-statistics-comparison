//@main
//struct MyMain {
//
//    static func main() {
//        var namesOfIntegers: [Int: Int] = [5: 32, 4: 42]
//        var access = namesOfIntegers[4]
//    }
//}
#include <map>
int main()
{
    std::map<int, int> namesOfIntegers = {{5,32}, {4,42}};
    int access = namesOfIntegers[4];
}
