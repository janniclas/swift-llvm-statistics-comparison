@main
struct MyMain {

    static func main() {
        var x = 42
        var y = 24
        swapTwoValues(&x, &y)
        // print("x: \(x) y: \(y)")
        var z = "World"
        var i = "Hello"
        swapTwoValues(&z, &i)
        // print(z + i)
    }

    static func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
}
