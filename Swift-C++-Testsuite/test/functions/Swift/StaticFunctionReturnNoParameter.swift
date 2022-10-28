@main
struct MyMain {

    static func main() {
        let myRes = noParamWithReturn()
    }
    static func noParamWithReturn() -> Int {
        let a = 5
        let b = 10
        let c = a + b
        return c
    }
}
