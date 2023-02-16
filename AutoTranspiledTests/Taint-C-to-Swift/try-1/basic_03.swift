

struct Pair {
    var A: Int
    var B: Int
}

func makePair() -> Pair {
    var P = Pair()
    P.A = 0
    P.B = 0
    return P
}

func taintPair(P: inout Pair) -> Pair {
    P.A = 13
    P.B = 13
    return P
}

func main() -> Int {
    var P = makePair()
    var Q = taintPair(P: &P)
    return Q.A
}