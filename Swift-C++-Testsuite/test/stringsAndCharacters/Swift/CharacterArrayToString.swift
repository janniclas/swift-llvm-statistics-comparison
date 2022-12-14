@main
struct MyMain {

    static func main() {
        var myword: [Character] = ["H", "e", "l", "l", "o", "\0"]
        var myWordString = String(myword)
    }
}
