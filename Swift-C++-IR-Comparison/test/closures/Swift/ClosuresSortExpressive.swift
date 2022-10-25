@main
struct MyMain {

    static func main() {
        let numbers = [42, 1, 47, 22, 23, 24]
        var reversedNumbers = numbers.sorted(by: backward)
    }

}

func backward(_ s1: Int, _ s2: Int) -> Bool {
    return s1 > s2
}
