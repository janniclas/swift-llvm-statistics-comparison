// As an optimization, Swift may instead capture and store a copy of
//  a value if that value isn’t mutated by a closure, and if the value
//  isn’t mutated after the closure is created.

// Swift also handles all memory management involved in disposing of
// variables when they’re no longer needed.

@main
struct MyMain {

    static func main() {
        var completionHandlers: [() -> Void] = []
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }
        for h in completionHandlers {
            h()
        }
    }

}


