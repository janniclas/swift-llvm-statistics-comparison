
var cond: Bool

func decrement(i: Int) -> Int {
    if cond {
        return decrement(i: -1)
    } else {
        return -1
    }
}

func main() {
    let j = decrement(i: -42)
    return 0
}