@main
struct MyMain {

    static func main() {
        // This call would crash with a normal add.
        // returns -9223372036854775808
        let a = subWithOverflow(x: Int.min)
    }

    // The & sign turns an subition to an substraction without overflow
    static func subWithOverflow(x: Int) -> Int {
        let tmp = x &- 1
        return tmp
    }
}
