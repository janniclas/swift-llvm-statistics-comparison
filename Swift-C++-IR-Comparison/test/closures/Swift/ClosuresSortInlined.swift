@main
struct MyMain {

    static func main() {
        let numbers = [42, 1, 47, 22, 23, 24]
        var reversedNumbers = numbers.sorted(by: { (s1: Int, s2: Int) -> Bool in return s1 > s2 })
    }

}
