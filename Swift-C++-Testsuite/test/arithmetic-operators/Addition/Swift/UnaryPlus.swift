@main
struct MyMain {

    static func main() {
        let _ = unaryPlus(x: -1)
    }

    // Documentation states the following
    // The unary plus operator (+) simply returns the value it operates on, without any change
    static func unaryPlus(x: Int) -> Int {
        var a = x
        var b = +a
        return b
    }
}
