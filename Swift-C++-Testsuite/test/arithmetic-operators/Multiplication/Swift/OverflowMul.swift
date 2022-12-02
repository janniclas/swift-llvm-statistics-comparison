@main
struct MyMain {

    static func main() {
        // This call would crash with a normal add.
        // returns -9223372036854775808
        let a = mulWithOverflow(x: Int.max)
    }

    // The & sign turns an mulition to an mulition without overflow
    static func mulWithOverflow(x: Int) -> Int {
        var tmp = x &* 2
        return tmp
    }
}
