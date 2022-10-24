@main
struct MyMain {

    static func main() {
        var counter = 0
        var max = 12
    outsideLoop: while counter < max {
        counter += 1
        switch(counter) {
        case 1...4:
            continue outsideLoop
        default:
            break outsideLoop
        }
        }
        print(counter)
    }
}
