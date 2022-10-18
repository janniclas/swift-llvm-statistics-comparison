

@main
struct MyMain {

    static func main() {
        // The code of this method can't be directly placed inside
        // the main function or it would be removed by the compiler
        // and replaced by the result. 
        // TODO: need to check this
        let a = simpleMul(x:42, y:42)
    }

    // We need to store, return, or use the result of the mulition to keep
    // the compiler to remove it during optimization.
    static func simpleMul(x: Int, y: Int) -> Int {
        let tmp = x * y
        return tmp
    }
}