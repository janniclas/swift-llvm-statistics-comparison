@main
struct MyMain {

  static func main() {
    var emptyArrayNoType: [Any] = []
    var emptyArray: [Int] = []

    var numberArrayNoType = [1, 2, 3, 4, 5]
    var numberArrayExplicitType: [Int] = [1, 2, 3, 4, 5]

    var stringArrayNoType = ["Test", "Input"]
    var stringArrayExplicitType: [String] = ["Test", "Input"]
  }
}
