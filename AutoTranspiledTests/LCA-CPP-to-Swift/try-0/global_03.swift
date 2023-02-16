
var g = 0;

func foo() {
    g += 1;
}

func main() {
    var i = 42;
    g += 1;
    foo();
    return 0;
}