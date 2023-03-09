class A {
    func myMethod() {
        print("I'm in Class A")
    }
}

class B: A {
    override func myMethod() {
        print("I'm in Class B")
    }
}
@main
struct MyMain {
    static func main() {
        var a = A()
        a.myMethod()
        var b = B()
        b.myMethod()
    }
}
