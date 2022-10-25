// As an optimization, Swift may instead capture and store a copy of
//  a value if that value isn’t mutated by a closure, and if the value
//  isn’t mutated after the closure is created.

// Swift also handles all memory management involved in disposing of
// variables when they’re no longer needed.

@main
struct MyMain {

    static func main() {
        var customersInLine = [1, 2, 3, 4, 5, 6, 42]

        func serve(customer customerProvider: @autoclosure () -> Int) {
            let tmp = customerProvider()
        }
        serve(customer: customersInLine.remove(at: 0))
    }
}

