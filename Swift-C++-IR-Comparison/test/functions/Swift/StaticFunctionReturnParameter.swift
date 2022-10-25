@main
struct MyMain {

    static func main() {
        let myRes = identity(x: 42)
    }
    static func identity(x: Int)-> Int {
        return x
    }
}
