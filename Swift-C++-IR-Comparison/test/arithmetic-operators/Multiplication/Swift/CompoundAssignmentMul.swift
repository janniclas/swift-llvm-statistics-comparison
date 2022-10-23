@main
struct MyMain {

  static func main() {
    let b = -1
    let a = compoundAssignmentMul(x: b, y: 42)
  }

  // Code is semantically equivalent to the normal mul test.
  // Slight difference, because it doesn't generate the llvm.lifetime
  // operations, but this shouldn't have any implications to any static
  // code analyses.
  static func compoundAssignmentMul(x: Int, y: Int) -> Int {
    var tmp = x
    tmp *= y
    return tmp
  }
}
