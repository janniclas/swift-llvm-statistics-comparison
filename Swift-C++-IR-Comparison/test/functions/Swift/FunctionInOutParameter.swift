@main
struct MyMain {

    static func main() {
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
    }

}

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}