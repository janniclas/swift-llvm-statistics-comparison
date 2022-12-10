@main
struct MyMain {

    static func main() {

        var greeting = "Guten Tag!"
        greeting[greeting.startIndex]
        // G
        greeting[greeting.index(before: greeting.endIndex)]
        // !
        greeting[greeting.index(after: greeting.startIndex)]
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        greeting[index]
        // a

        for index in greeting.indices {
            var curr = greeting[index]
        }

        greeting.insert("!", at: greeting.endIndex)

        greeting.removeSubrange(greeting.index(greeting.endIndex, offsetBy: -2)..<greeting.endIndex)
    }
}
