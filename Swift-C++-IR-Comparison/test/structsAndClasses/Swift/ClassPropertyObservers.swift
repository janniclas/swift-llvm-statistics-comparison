// If you pass a property that has observers to a function as an in-out parameter,
// the willSet and didSet observers are always called. This is because of the
// copy-in copy-out memory model for in-out parameters: The value is always written
// back to the property at the end of the function. For a detailed discussion of
// the behavior of in-out parameters, see In-Out Parameters.

@main
struct MyMain {

    static func main() {
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
    }
}
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
