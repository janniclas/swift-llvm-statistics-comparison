@main
struct MyMain {

  static func main() {
    let b = -1
    let a = unaryPlus(x: b)
  }

  // Documentation states the following
  // The unary plus operator (+) simply returns the value it operates on, without any change
  static func unaryPlus(x: Int) -> Int {
    let tmp = +x
    return tmp
  }
}
