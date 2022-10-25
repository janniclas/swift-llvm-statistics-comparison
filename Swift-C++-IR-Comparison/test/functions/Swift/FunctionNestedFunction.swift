@main
struct MyMain {

    static func main() {
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
    }

}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
