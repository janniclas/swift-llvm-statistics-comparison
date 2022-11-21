@main
struct MyMain {

    static func main() {
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
    }
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

protocol Togglable {
    mutating func toggle()
}
