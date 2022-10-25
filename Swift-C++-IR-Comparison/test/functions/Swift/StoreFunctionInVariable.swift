@main
struct MyMain {

    static func main() {
        var mathFunction: (Int, Int) -> Int = addTwoInts
        var result = mathFunction(42, 44)
    }

}

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
