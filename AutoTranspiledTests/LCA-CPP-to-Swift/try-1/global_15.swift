
 var g1 = 0
 var g2 = 99
 
 struct X {
   init() {
     g1 = 1024
   }
 }
 
 struct Y {
   init() {
     g2 = g2 + 1
   }
   deinit {
     g1 = g2 + 13
   }
 }
 
 func foo(x: Int) -> Int {
   x += 1
   return x
 }
 
 let var = X()
 let war = Y()
 
 let a = g1
 let b = g2
 a = foo(x: a)
 
 return a + 30