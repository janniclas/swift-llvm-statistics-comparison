// Collections defined by the standard library like arrays,
// dictionaries, and strings use an optimization to reduce the
// performance cost of copying. Instead of making a copy immediately,
// these collections share the memory where the elements are stored
// between the original instance and any copies. If one of the copies
// of the collection is modified, the elements are copied just before the
// modification. The behavior you see in your code is always as if a copy
// took place immediately.

@main
struct MyMain {

    static func main() {
        let res = Resolution(width: 1920, height: 1080)
        var copied = res
        copied.height = 42
        print(res.height)
        print(copied.height)
    }
}

struct Resolution {
    var width = 0
    var height = 0
}
