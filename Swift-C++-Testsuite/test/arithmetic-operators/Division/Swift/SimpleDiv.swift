@main
struct MyMain {

    static func main() {
        // The code of this method can't be directly placed inside
        // the main function or it would be removed by the compiler
        // due to mandatory optimizations.
        var _ = simpleDiv(x: 15)
    }

    static func simpleDiv(x: Int) -> Int {
        var a = x
        var b = a / 5
        return b
    }
}
