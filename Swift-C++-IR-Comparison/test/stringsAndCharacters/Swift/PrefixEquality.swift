@main
struct MyMain {

    static func main() {
        let greeting = "hello there"
        let t = greeting.hasPrefix("hello")
        let f = greeting.hasPrefix("there")
    }
}
