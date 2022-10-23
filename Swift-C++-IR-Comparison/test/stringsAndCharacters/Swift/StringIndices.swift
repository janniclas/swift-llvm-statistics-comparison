@main
struct MyMain {

  static func main() {

    let greeting = "Guten Tag!"
    greeting[greeting.startIndex]
    // G
    greeting[greeting.index(before: greeting.endIndex)]
    // !
    greeting[greeting.index(after: greeting.startIndex)]
    // u
    let index = greeting.index(greeting.startIndex, offsetBy: 7)
    greeting[index]
    // a

    for index in greeting.indices {
      let tmp = greeting[index]
    }
    // Prints "G u t e n   T a g ! "

    // Insert Examples
    var welcome = "hello"
    welcome.insert("!", at: welcome.endIndex)
    // welcome now equals "hello!"

    welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
    // welcome now equals "hello there!"

    welcome.remove(at: welcome.index(before: welcome.endIndex))
    // welcome now equals "hello there"

    let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
    welcome.removeSubrange(range)
    // welcome now equals "hello"

    let greeting2 = "Hello, world!"
    let index2 = greeting2.firstIndex(of: ",") ?? greeting2.endIndex
    let beginning = greeting2[..<index2]
    // beginning is "Hello"

    // Convert the result to a String for long-term storage.
    let newString = String(beginning)

  }
}
