
 
import Foundation

func foo(x: Int) -> Int {
    while random() > 0 {
        x += 1
    }
    return x
}

func main() -> Int { 
    let a = 3 
    let b = foo(x: a) 
    return b 
}