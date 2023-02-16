
var g1 = 0
var g2 = 99

struct X {
    init() {
        g1 = 1024
    }
}

struct Y {
    init() {
        g2 = g2 + 1
    }
    
    deinit {
        g1 = g2 + 13
    }
}

func foo(x: inout Int) -> Int {
    x += 1
    return x
}

var var = X()
var war = Y()

func main() -> Int {
    var a = g1
    let b = g2
    a = foo(x: &a)
    return a + 30
}