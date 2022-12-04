@main
struct M42Main {

    static func main() {
        var _ = numberEqual(x: 42)  // true
        var _ = numberEqual(x: 41)  // false
        var _ = numberNotEqual(x: 42)  // false
        var _ = numberNotEqual(x: 41)  // true
        var _ = numberLarger(x: 43)  // true
        var _ = numberLarger(x: 41)  //false
        var _ = numberSmaller(x: 41)  // true
        var _ = numberSmaller(x: 43)  // false
        var _ = numberLargerOrEqual(x: 42)  // true
        var _ = numberLargerOrEqual(x: 41)  // false
        var _ = numberSmallerOrEqual(x: 42)  // true
        var _ = numberSmallerOrEqual(x: 43)  // false
    }

    static func numberEqual(x: Int) -> Bool {
        var tmp = x == 42
        return tmp
    }
    static func numberNotEqual(x: Int) -> Bool {
        var tmp = x != 42
        return tmp
    }
    static func numberLarger(x: Int) -> Bool {
        var tmp = x > 42
        return tmp
    }
    static func numberSmaller(x: Int) -> Bool {
        var tmp = x < 42
        return tmp
    }
    static func numberLargerOrEqual(x: Int) -> Bool {
        var tmp = x >= 42
        return tmp
    }
    static func numberSmallerOrEqual(x: Int) -> Bool {
        var tmp = x <= 42
        return tmp
    }
}
