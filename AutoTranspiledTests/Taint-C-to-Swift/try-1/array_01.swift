

var buffer = [CChar](repeating: 42, count: 128)
buffer[42] = 13
let p = buffer[42]