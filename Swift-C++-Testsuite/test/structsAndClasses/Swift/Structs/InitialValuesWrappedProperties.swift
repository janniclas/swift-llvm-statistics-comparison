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
        var rectangle = ZeroRectangle()
        var unitRectangle = UnitRectangle()
        var mixedRectangle = MixedRectangle()
        mixedRectangle.width = 12
    }
}
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}
