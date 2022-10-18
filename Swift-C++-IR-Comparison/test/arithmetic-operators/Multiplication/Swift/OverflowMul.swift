
@main
struct MyMain {

    static func main() {
        // This call would crash with a normal add. 
        // returns -9223372036854775808
        let a = mulWithOverflow(x:Int.max, y:2)
    }

    // The & sign turns an mulition to an mulition without overflow
    static func mulWithOverflow(x: Int, y: Int) -> Int {
        let tmp = x &* y
        return tmp
    }
}