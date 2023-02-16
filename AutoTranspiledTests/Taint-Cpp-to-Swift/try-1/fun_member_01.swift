 
 class X {
    var A: Int
    var B: Int
    
    init(A: Int, B: Int) {
        self.A = A
        self.B = B
    }
    
    func foo() -> Int {
        return A + B + 13
    }
    
    func bar(V: inout Int) {
        V = A + B
    }
 }

 func main() -> Int {
     let v = X(A: 13, B: 42)
     v.A = 20 
     v.B = 40
     let c = v.foo()
     var d = 20
     v.bar(&d)
     return v.A + v.B
 }
 print(main())