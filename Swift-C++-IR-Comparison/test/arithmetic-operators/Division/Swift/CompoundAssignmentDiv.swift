@main
struct MyMain {

    static func main() {
        let b = -1
        let a = simplediv(x: b, y: 42)
    }

    // We need to store, return, or use the result of the divition to keep
    // the compiler to remove it during optimization.
    static func simplediv(x: Int, y: Int) -> Int {
        let tmp = x / y
        return tmp
    }
}
