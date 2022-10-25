int defaultParameter(int x = 42)
{
    return x + 2;
}
int main() {
    int withExplicitValue = defaultParameter(44);
    int withDefault = defaultParameter();
    return 0;
}

// @main
// struct MyMain {

//     static func main() {
//         let withExplicitValue = defaultParameter(x: 44)
//         let withDefault = defaultParameter()
//     }

// }

// func defaultParameter(x: Int = 42) -> Int {
//     return x + 2
// }
