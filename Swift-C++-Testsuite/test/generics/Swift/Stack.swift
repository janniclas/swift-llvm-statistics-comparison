@main
struct MyMain {

    static func main() {
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        var stackOfNumbers = Stack<Int>()
        stackOfNumbers.push(1)
        stackOfNumbers.push(2)
        stackOfNumbers.push(3)
        stackOfNumbers.push(4)
    }
}

struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
