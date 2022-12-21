@main
struct MyMain {

    static func main() {
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]

        let isSubset = oddDigits.isSubset(of: evenDigits)
    }
}
