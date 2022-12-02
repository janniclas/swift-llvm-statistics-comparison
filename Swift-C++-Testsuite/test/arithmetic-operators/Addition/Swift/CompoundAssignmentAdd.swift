@main
struct MyMain {

    static func main() {
        let _ = compoundAssignment(x: -1, y: 42)
    }

    // Code is semantically equivalent to the normal add test.
    // Slight difference, because it doesn't generate the llvm.lifetime
    // operations, but this shouldn't have any implications to any static
    // code analyses.
    static func compoundAssignment(x: Int, y: Int) -> Int {
        var a = x
        var b = y
        a += b
        return a
    }
}
