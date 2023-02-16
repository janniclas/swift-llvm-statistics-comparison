
var Buffer: Array<Character> = Array(repeating: "42", count: 128)
Buffer[42] = "13"
let P = Buffer[42]
Buffer.removeAll()