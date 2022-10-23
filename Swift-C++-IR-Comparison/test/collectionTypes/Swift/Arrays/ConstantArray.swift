@main
struct MyMain {

  static func main() {
    let emptyArrayNoType: [Any] = []
    let emptyArray: [Int] = []

    let numberArrayNoType = [1, 2, 3, 4, 5]
    let numberArrayExplicitType: [Int] = [1, 2, 3, 4, 5]

    let stringArrayNoType = ["Test", "Input"]
    let stringArrayExplicitType: [String] = ["Test", "Input"]
  }
}
