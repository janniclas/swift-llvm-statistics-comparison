@main
struct MyMain {

    static func main() {
        // The code of this method can't be directly placed inside
        // the main function or it would be removed by the compiler
        // and replaced by 84.
        var c = simpleAdd(x: 42, y: 42)
        c = 1
    }

    static func simpleAdd(x: Int, y: Int) -> Int {
        let tmp = x + y
        return tmp
    }
}
