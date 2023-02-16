
 
class X {
    var V: Int
    
    init(V: Int) {
        self.V = V
    }
    
    convenience init(copy: X) {
        self.init(V: copy.V)
    }
    
    deinit {
        print("V is: \(V)")
    }
    
    func sanit() {
        print("V is: \(V)")
    }
    
    static func returnMagic() -> Int {
        return 42
    }
}

func main() {
    let V = X(V: 13)
    let W = X(copy: V)
    let Y = X(V: X.returnMagic())
    Y.sanit()
    return W.V
}