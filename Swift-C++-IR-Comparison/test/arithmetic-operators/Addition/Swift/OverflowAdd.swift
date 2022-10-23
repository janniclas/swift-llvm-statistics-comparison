@main
struct MyMain {

  static func main() {
    // This call would crash with a normal add.
    // returns -9223372036854775808
    let a = addWithOverflow(x: Int.max, y: 1)
  }

  // The & sign turns an addition to an addition without overflow
  static func addWithOverflow(x: Int, y: Int) -> Int {
    let tmp = x &+ y
    return tmp
  }
}
