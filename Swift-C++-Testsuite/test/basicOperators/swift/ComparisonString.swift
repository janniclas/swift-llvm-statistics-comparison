@main
struct MyMain {

    static func main() {
        var _ = stringEqual(x: "world")  // true
        var _ = stringEqual(x: "hello")  // false
        var _ = stringNotEqual(x: "world")  // false
        var _ = stringNotEqual(x: "hello")  // true
        var _ = stringLarger(x: "world")  // true
        var _ = stringLarger(x: "hello")  //false
        var _ = stringSmaller(x: "hello")  // true
        var _ = stringSmaller(x: "world")  // false
        var _ = stringLargerOrEqual(x: "world")  // true
        var _ = stringLargerOrEqual(x: "hello")  // false
        var _ = stringSmallerOrEqual(x: "world")  // true
        var _ = stringSmallerOrEqual(x: "hello")  // false
    }

    static func stringEqual(x: String) -> Bool {
        var tmp = x == "world"
        return tmp
    }
    static func stringNotEqual(x: String) -> Bool {
        var tmp = x != "world"
        return tmp
    }
    static func stringLarger(x: String) -> Bool {
        var tmp = x > "world"
        return tmp
    }
    static func stringSmaller(x: String) -> Bool {
        var tmp = x < "world"
        return tmp
    }
    static func stringLargerOrEqual(x: String) -> Bool {
        var tmp = x >= "world"
        return tmp
    }
    static func stringSmallerOrEqual(x: String) -> Bool {
        var tmp = x <= "world"
        return tmp
    }
}
