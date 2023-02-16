 
import Foundation

func foo(x: Int) -> Int {
    while Int.random(in: 0...1) != 0 {
        x += 1
    }
    return x
}

let a = 3
let b = foo(x: a)
print(b)