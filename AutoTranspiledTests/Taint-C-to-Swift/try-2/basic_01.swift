
func foo(A: Int, B: Int) -> Int {
return 0
}

func bar() -> Int {
 return 0
}

func baz(A: Int, B: Int, C: Int) -> Int {
 return 0
}

func quark() { }

func average(Count: Int, Args: Double...) -> Double {
    var Tot = 0.0
    for J in Args {
        Tot += J
    }
    return Tot / Double(Count)
}

func main() -> Int {
    let A = foo(42, B: 13)
    let B = bar()
    var C = A + 42
    C = baz(C, B: A, C: B)
    quark()
    let Avg = average(1, Args: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    return C
}