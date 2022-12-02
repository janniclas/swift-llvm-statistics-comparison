@main
struct MyMain {

    static func main() {
        // The code of this method can't be directly placed inside
        // the main function or it would be removed by the compiler
        // and replaced by the result.
        let _ = simpleMul(x: 21)
    }

    // We need to store, return, or use the result of the mulition to keep
    // the compiler to remove it during optimization.
    static func simpleMul(x: Int) -> Int {
        var a = x
        var b = a * 2
        return b
    }
}
