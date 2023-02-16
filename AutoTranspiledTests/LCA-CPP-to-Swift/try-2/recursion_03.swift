
 func foo(_ i: UInt) -> UInt {
    if i == 0 {
        return 1
    }
    
    return foo(i - 1)
}

let a = foo(5)