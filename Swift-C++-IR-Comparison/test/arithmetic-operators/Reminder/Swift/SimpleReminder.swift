@main
struct MyMain {

    static func main() {
        let b = -1
        let a = simpleReminder(x: b, y: 42)
    }

    // We need to store, return, or use the result of the reminder to keep
    // the compiler to remove it during optimization.
    static func simpleReminder(x: Int, y: Int) -> Int {
        let tmp = x % y
        return tmp
    }
}
