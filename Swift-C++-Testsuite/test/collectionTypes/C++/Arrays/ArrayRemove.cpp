//@main
//struct MyMain {
//
//    static func main() {
//        var arr = [2, 42, 44]
//        arr.remove(at: 0)
//    }
//}
#include <vector>
int main()
{
    std::vector<int> a = {2, 42};
    a.erase(a.begin() + 1);
}
