@main
struct MyMain {

    static func main() {
        let burger = Food(name: "Tasty")
        let random = Food()
    }
}

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
