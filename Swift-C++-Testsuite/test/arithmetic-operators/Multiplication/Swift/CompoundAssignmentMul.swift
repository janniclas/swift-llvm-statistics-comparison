@main
struct MyMain {

    static func main() {
        let _ = compoundAssignmentMul(x: 21)
    }

    // Code is semantically equivalent to the normal mul test.
    // Slight difference, because it doesn't generate the llvm.lifetime
    // operations, but this shouldn't have any implications to any static
    // code analyses.
    static func compoundAssignmentMul(x: Int) -> Int {
        var a = x
        a *= 2
        return a
    }
}
