
var A = 42
var B = 0

func bar(A: Int, B: inout Int) -> Int {
    B = 13
    if A == 42 {
        return 13
    }
    return A
 }

fileprivate func foo(A: inout Int) {
    A = 13
}

func main() -> Int {
    let C = bar(A: A, B: &B)
    foo(A: &C)
    return C
}