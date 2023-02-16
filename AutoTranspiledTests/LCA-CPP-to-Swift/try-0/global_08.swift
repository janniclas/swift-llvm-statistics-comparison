
 var g = 1
 
 func baz(c: Int) -> Int {
    return g + c
 }

 func bar(b: Int) -> Int {
    return baz(c: b + 1)
 }

 func foo(a: Int) -> Int {
    return bar(b: a + 1)
 }

 func main() {
    g += 1
    var i = 0
    i = foo(a: 1)
    return
 }