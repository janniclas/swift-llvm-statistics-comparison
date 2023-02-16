
import Foundation

func foo(x: Int) -> Int {
    while arc4random() % 2 == 0 {
        x += 1
    }
    return x
}
let a = 3
let b = foo(x: a)
print(b)