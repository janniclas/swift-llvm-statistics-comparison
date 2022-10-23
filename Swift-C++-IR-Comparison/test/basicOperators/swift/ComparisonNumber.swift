@main
struct MyMain {

  static func main() {
    let a = 1 == 1  // true because 1 is equal to 1
    let b = 2 != 1  // true because 2 isn't equal to 1
    let c = 2 > 1  // true because 2 is greater than 1
    let d = 1 < 2  // true because 1 is less than 2
    let e = 1 >= 1  // true because 1 is greater than or equal to 1
    let f = 2 <= 1  // false because 2 isn't less than or equal to 1
  }

  static func numberEqual(x: Int, y: Int) -> Bool {
    let tmp = x == y
    return tmp
  }
  static func numberNotEqual(x: Int, y: Int) -> Bool {
    let tmp = x != y
    return tmp
  }
  static func numberxLarger(x: Int, y: Int) -> Bool {
    let tmp = x > y
    return tmp
  }
  static func numberYLarger(x: Int, y: Int) -> Bool {
    let tmp = x < y
    return tmp
  }
  static func numberXLargerOrEqual(x: Int, y: Int) -> Bool {
    let tmp = x >= y
    return tmp
  }
  static func numberYLargerOrEqual(x: Int, y: Int) -> Bool {
    let tmp = x <= y
    return tmp
  }
}
