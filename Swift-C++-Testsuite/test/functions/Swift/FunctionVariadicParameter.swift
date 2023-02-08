@main
struct MyMain {

    static func main() {
        let res = arithmeticMean(3.2, 8.25, 18.75)
    }

}

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
