@main
struct MyMain {

    static func main() {
        // The code of this method can't be directly placed inside
        // the main function or it would be removed by the compiler
        // due to mandatory optimizations.
        var a = 1
        var b = 2
        var c = 3
        a = inc(p: a)
        b = inc(p: b)
        c = b * 4
    }
    static func inc(p: Int) -> Int { return p + 1 }

}
