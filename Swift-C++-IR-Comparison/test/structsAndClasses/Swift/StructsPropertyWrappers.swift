// When you apply a wrapper to a property, the compiler synthesizes code
// that provides storage for the wrapper and code that provides access
// to the property through the wrapper. (The property wrapper is responsible
// for storing the wrapped value, so there’s no synthesized code for that.)
// You could write code that uses the behavior of a property wrapper, without
// taking advantage of the special attribute syntax. For example, here’s a version
// of SmallRectangle from the previous code listing that wraps its properties in the
// TwelveOrLess structure explicitly, instead of writing @TwelveOrLess as an attribute:
//
//struct SmallRectangle {
//    private var _height = TwelveOrLess()
//    private var _width = TwelveOrLess()
//    var height: Int {
//        get { return _height.wrappedValue }
//        set { _height.wrappedValue = newValue }
//    }
//    var width: Int {
//        get { return _width.wrappedValue }
//        set { _width.wrappedValue = newValue }
//    }
//}


@main
struct MyMain {

    static func main() {
        var rectangle = SmallRectangle()
        rectangle.height = 10
    }
}
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
