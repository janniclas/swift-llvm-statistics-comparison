
func bar(A: Int, B: inout Int) -> Int {
    B = 13
    
    if A == 42 {
        return 13
    }
    
    return A
}

func main() -> Int {
    var A = 42
    var B = 0
    let C = bar(A: A, B: &B)
    return C
}