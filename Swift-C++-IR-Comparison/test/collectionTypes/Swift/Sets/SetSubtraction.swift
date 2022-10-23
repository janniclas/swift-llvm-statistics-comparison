

@main
struct MyMain {

    static func main() {
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        oddDigits.subtracting(singleDigitPrimeNumbers)
    }
}
