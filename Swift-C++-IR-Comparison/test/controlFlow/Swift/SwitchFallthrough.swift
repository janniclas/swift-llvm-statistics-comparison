@main
struct MyMain {

    static func main() {
        let res = switchMe(input: (2, 3))
    }

    static func switchMe(input: (Int, Int)) -> Int {
        var counter = 0
        var max = 7
        switch input {
        case (let x, 0):
            counter = 100
            fallthrough
        case (0, let y):
            counter = -y
        case let (x, y):
            counter = -x
        default:
            counter = 42
        }
        return counter
    }
}
