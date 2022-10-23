func magical(z: Int) -> Int {
    let a = 78_092_178
    let b = 45124
    let x = a + b
    return x + z
}
let rand = Int.random(in: 1..<100)
var myResult = -1
if rand < 40 {
    myResult = magical(z: rand)
    // 78149714
} else {
    myResult = magical(z: 12411)
    // 78149713
}
