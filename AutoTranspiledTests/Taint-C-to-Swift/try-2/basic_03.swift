
 
struct Pair {
    var A :Int
    var B :Int
}
 
func makePair() -> Pair {
    var P = Pair(A: 0, B: 0)
    return P
}
 
func taintPair(_ P: inout Pair) -> Pair {
    P.A = 13
    P.B = 13
    return P;
}
 
let P = makePair()
var Q = taintPair(&P)
print(Q.A)