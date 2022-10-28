// As an optimization, Swift may instead capture and store a copy of
//  a value if that value isn’t mutated by a closure, and if the value
//  isn’t mutated after the closure is created.

// Swift also handles all memory management involved in disposing of
// variables when they’re no longer needed.

@main
struct MyMain {

    static func main() {
        var customersInLine = [1, 2, 3, 4, 5, 6, 42]
        var customerProviders: [() -> Int] = []

        func collectProvider(_ customerProvider: @autoclosure @escaping () -> Int) {
            customerProviders.append(customerProvider)
        }

        collectProvider(customersInLine.remove(at: 0))
        collectProvider(customersInLine.remove(at: 0))

        for provider in customerProviders {
            let result = provider()
        }
    }
}
