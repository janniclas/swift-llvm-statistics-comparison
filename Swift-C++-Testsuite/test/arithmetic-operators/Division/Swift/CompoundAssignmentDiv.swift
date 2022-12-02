@main
struct MyMain {

    static func main() {
        let _ = compoundAssignment(x: 15)
    }

    // Code is semantically equivalent to the normal add test.
    // Slight difference, because it doesn't generate the llvm.lifetime
    // operations, but this shouldn't have any implications to any static
    // code analyses.
    static func compoundAssignment(x: Int) -> Int {
        var a = x
        a /= 5
        return a
    }
}
