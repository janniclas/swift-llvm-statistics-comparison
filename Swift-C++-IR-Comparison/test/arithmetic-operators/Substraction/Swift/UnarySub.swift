@main
struct MyMain {

    static func main() {
        let b = -1
        let a = unaryMinus(x: b)
    }

    // The unary minus operator (-) inverts the current sign.
    // It performs the sign switch by calculating 0 - x
    static func unaryMinus(x: Int) -> Int {
        let tmp = -x
        return tmp
    }
}
