@main
struct MyMain {

    static func main() {
        let _ = simpleReminder(x: 43)
    }

    // We need to store, return, or use the result of the reminder to keep
    // the compiler to remove it during optimization.
    static func simpleReminder(x: Int) -> Int {
        var a = x
        var b = a % 2
        return b
    }
}
