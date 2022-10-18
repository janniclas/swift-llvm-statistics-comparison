
@main
struct MyMain {

    static func main() {
        let b = -1
        // TODO: need to check wether the compiler also replaces the calculation
        // here.
        let a = compoundAssignmentdiv(x: b, y: 42)
    }

    // Code is semantically equivalent to the normal div test.
    // Slight difference, because it doesn't generate the llvm.lifetime
    // operations, but this shouldn't have any implications to any static
    // code analyses.
    static func compoundAssignmentdiv(x: Int, y: Int) -> Int {
        var tmp = x
        tmp /= y
        return tmp
    }
}