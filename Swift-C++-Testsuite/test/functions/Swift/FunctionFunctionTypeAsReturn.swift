@main
struct MyMain {

    static func main() {
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
    }

}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
