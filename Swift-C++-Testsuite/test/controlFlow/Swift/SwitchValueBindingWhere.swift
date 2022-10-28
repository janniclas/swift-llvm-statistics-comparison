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
            counter = x
        case (0, let y):
            counter = -y
        case let (x, y) where x == y:
            counter = -x
        }
        return counter
    }
}
