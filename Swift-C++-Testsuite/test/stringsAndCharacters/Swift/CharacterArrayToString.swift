@main
struct MyMain {

    static func main() {
        let myword: [Character] = ["H", "e", "l", "l", "o", "\0"]
        let myWordString = String(myword)
    }
}
