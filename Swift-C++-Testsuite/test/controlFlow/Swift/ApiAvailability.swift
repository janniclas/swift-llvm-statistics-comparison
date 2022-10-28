@main
struct MyMain {

    static func main() {
        var counter = 0
        if #available(iOS 10, macOS 10.12, *) {
            counter = 42
        } else {
            counter = 44
        }
    }

}
