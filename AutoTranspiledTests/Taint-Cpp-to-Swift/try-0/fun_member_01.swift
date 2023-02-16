

struct X {
    var A: Int
    var B: Int

    init(A: Int, B: Int) {
        self.A = A
        self.B = B
    }

    func foo() -> Int {
        return A + B + 13
    }

    func bar(V: inout Int) {
        V = A + B
    }
}

func main() -> Int {
    var V = X(A: 13, B: 42)
    V.A = 20
    V.B = 40
    var C = V.foo()
    var D = 20
    V.bar(V: &C)
    return V.A + V.B
}

main()