import Foundation

func validBraces(_ string:String) -> Bool {


    var stack = Stack()

    for c in string {
        let s = String(c)
        if(s == "(" || s == "{" || s == "[") {
            stack.push(element: s)
        } else {
            if(stack.isEmpty()) {
              return false
            }
            let lastOpen = stack.pop()
            if (!matches(open: lastOpen, close: s)) {
                return false;
            }
        }
    }
    return true;
}

func matches(open: String, close: String) -> Bool {
    if(open == "(" && close == ")" || open == "{" && close == "}" || open == "[" && close == "]")
    { return true}
    return false
}


struct Stack {
  
    func isEmpty() -> Bool {
      return self.data.isEmpty
    }
    var data: [String] = []

    mutating func push(element: String) {
        self.data.append(element)
    }

    mutating func pop() -> String {
        return self.data.removeLast()
    }
}

let testInput = "({})[({})]"
print(validBraces(testInput))