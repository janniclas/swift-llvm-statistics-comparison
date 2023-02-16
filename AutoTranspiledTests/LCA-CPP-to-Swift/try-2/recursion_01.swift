
var cond = true
func decrement(i: Int) -> Int
{
    if cond {
        return decrement(i-1)
    }
    return -1
}

var j = decrement(i: -42)