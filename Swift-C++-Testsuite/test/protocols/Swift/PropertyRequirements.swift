@main
struct MyMain {

    static func main() {
        let john = Person(fullName: "John Appleseed")
        var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
    }

}

struct Person: FullyNamed {
    var fullName: String
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

protocol FullyNamed {
    var fullName: String { get }
}
