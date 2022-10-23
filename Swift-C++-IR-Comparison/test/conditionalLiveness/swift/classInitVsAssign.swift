// example taken from "Swift's High-Level IR: A Case Study"

class SomeClass {
  var text: String
  init(text: String) {
    self.text = text
  }
  func ask() {
    print(text)
  }
}

func testDI(cond: Bool) {
  var c: SomeClass
  if cond {
    c = SomeClass(text: "12345")
  }

  c = SomeClass(text: "6789")  // init or assign?

  c.ask()

}

testDI(cond: Int.random(in: 1..<100) > 50)
