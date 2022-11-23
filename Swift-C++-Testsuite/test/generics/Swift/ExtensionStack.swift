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
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem).")
        }
        if let topItem = stackOfNumbers.topItem {
            print("The top item on the stack is \(topItem).")
        }
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

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
