@main
struct MyMain {

    static func main() {
        let res = switchMe(input: (2, 3))
    }

    static func switchMe(input: (Int, Int)) -> Int {
        var counter = 0
        var max = 7
        switch input {
        case (1, 1):
            counter = max
        case (0, 1):
            counter = -max
        case (0, _):
            counter = -max
        default:
            counter = 42
        }
        return counter
    }
}
