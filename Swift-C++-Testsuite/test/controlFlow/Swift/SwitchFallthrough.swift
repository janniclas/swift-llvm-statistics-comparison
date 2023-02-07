@main
struct MyMain {

    static func main() {
        let res = switchMe(input: (2))
    }

    static func switchMe(input: Int) -> Int {
        var counter = 0
        switch input {
        case 2:
            counter = 100
            fallthrough
        case 3:
            counter -= 23
        default:
            counter = 42
        }
        return counter
    }
}
