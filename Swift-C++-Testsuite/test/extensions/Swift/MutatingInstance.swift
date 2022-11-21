@main
struct MyMain {

    static func main() {
        var someInt = 3
        someInt.square()
    }
}

extension Int {
    mutating func square() {
        self = self * self
    }
}
