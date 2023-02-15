@main
struct MyMain {

    static func source() -> String {
        print("Source")
        return "Secret"
    }

    static func sink(leaked: String) {
        print("Leaked \(leaked).")
    }

    static func main() {
        var secret = source()
        var copied = secret
        secret = ""
        copied = copied + "test"
        sink(leaked: copied)
    }
}
