@main
struct MyMain {

    static func main() {
        let greeting = "Hello There"
        let notPrefix = greeting.hasPrefix("here")
        let isPrefix = greeting.hasPrefix("Hello")
    }
}
