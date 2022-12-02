@main
struct MyMain {

    static func main() {

        let _ = unaryMinus(x: -1)
    }

    // The unary minus operator (-) inverts the current sign.
    // It performs the sign switch by calculating 0 - x
    static func unaryMinus(x: Int) -> Int {
        var a = x
        var b = -a
        return b
    }
}
