// As an optimization, Swift may instead capture and store a copy of
//  a value if that value isn’t mutated by a closure, and if the value 
//  isn’t mutated after the closure is created.

// Swift also handles all memory management involved in disposing of 
// variables when they’re no longer needed.

@main
struct MyMain {

    static func main() {
        let incrementByTen = makeIncrementer(forIncrement: 10)
        incrementByTen()
        incrementByTen()
    }

}

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
