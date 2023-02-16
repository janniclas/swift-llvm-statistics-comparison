
 func foo(a: Int, b: Int) -> Int {
    a += b
    b += a
    return a + b
 }

 var k: Int = foo(a: 1, b: 2)