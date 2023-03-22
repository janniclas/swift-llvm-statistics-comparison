public struct SimpleLibraryTest {

    public init() {
        var result = wrapper(42)
        print(result)
        if Int.random(in: 1..<100) < 50 {
            var externalResult = externalFunction(x: result)
            print(externalResult)
        }
    }
            

     func wrapper(_ x: Int) -> Int {
        var i = x
        var j = i * 3
        return j
    }
}
