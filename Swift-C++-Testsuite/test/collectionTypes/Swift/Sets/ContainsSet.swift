@main
struct MyMain {

    static func main() {
        var numberSet = Set<Int>()
        numberSet.insert(42)
        var contains = numberSet.contains(42)
        var notContained = numberSet.contains(44)
    }
}
