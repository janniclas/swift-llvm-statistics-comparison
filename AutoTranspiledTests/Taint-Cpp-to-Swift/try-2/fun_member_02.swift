 
 class X {
    let V: Int
 
    init(_ V: Int) {
        self.V = V
    }
 
    init(copyOf X: X) {
        self.V = X.V
    }
 
    static func returnMagic() -> Int {
        return 42
    }
 
    deinit { //Function called when the object is destroyed
        print("V is: \(V)")
    }
 
    func sanit() {
        print("V is: \(V)")
    }
 }
 
 func main() -> Int{
    let v = X(13)
    let w = X(copyOf: v)
    let y = X(returnMagic())
    y.sanit()
    return w.V
 }
 
 main()