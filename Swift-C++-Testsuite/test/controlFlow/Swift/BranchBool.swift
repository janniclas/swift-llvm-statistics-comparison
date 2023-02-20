@main
struct MyMain {
    static func main() {
        var i = 10
        var cond = getCondition(i)
        if cond {
            i = 2
        }
    }

    static func getCondition(_ x: Int) -> Bool {
        var res: Bool
        if x < 10 {
            res = true
            return res
        } else {
            res = false
            return res
        }
    }
}
