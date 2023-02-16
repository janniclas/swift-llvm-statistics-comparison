

func foo(a: Int, b: Int) -> Int {
    a += b
    b += a 
    return a + b
}

var k: Int
k = foo(a: 1, b: 2)