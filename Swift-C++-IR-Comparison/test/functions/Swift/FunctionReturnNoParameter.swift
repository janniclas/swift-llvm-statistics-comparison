@main
struct MyMain {

    static func main() {
        let myRes = noParamWithReturn()
    }

}

func noParamWithReturn()-> Int {
    let a = 5
    let b = 10
    let c = a+b
    return c
}
