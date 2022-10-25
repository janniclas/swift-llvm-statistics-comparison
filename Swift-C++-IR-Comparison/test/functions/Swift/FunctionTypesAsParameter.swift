@main
struct MyMain {

    static func main() {
        var mathFunction: (Int, Int) -> Int = addTwoInts
        var result = takeMathFunction(mathFunction, 42, 44)
    }

}

func takeMathFunction(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let exec = mathFunction(a, b)
}

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
