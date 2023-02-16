

struct X {
    let V: Int
    
    init(V: Int) {
        self.V = V
    }
    
    func sanit() {
        print("V is: \(V)")
    }
    
    static func returnMagic() -> Int {
        return 42
    }
    
    deinit {
        print("V is: \(V)")
    }
}

func main() -> Int {
    let V = X(V: 13)
    let W = V
    let Y = X(V: X.returnMagic())
    Y.sanit()
    
    return W.V
}

main()