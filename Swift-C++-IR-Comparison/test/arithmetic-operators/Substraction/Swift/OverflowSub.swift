
@main
struct MyMain {

    static func main() {
        // This call would crash with a normal add. 
        // returns -9223372036854775808
        let a = subWithOverflow(x:Int.min, y:1)
    }

    // The & sign turns an subition to an substraction without overflow
    static func subWithOverflow(x: Int, y: Int) -> Int {
        let tmp = x &- y
        return tmp
    }
}