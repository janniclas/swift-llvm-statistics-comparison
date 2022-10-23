@main
struct MyMain {

  static func main() {
    let greeting = "hello there"
    let t = greeting.hasSuffix("there")
    let f = greeting.hasSuffix("!")
  }
}
