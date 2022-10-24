@main
struct MyMain {

    static func main() {
        var namesOfIntegers: [Int: Int] = [5: 32, 4: 42]
        namesOfIntegers.remove(at: 2)
    }
}
