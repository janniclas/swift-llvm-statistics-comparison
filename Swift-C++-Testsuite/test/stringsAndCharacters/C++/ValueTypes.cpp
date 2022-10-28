// Swift’s String type is a value type. If you create a new String value,
//  that String value is copied when it’s passed to a function or method, 
//  or when it’s assigned to a constant or variable. In each case, a new copy 
//  of the existing String value is created, and the new copy is passed or assigned,
//   not the original version. Value types are described in Structures and Enumerations Are Value Types.


// @main
// struct MyMain {

//     static func main() {
//         // search builtinStringLiteral.* in swift repository 
//         // sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC
//         let greeting = "Hello World!"
//         takeStringGiveString(input: greeting)
//         takeStringMutateGiveString(input: greeting)
//         identity(input: greeting)

//     }

//     // Behind the scenes, Swift’s compiler optimizes string usage so that actual
//     // copying takes place only when absolutely necessary. This means you always
//     // get great performance when working with strings as value types.
//     static func takeStringMutateGiveString(input: String) -> String {
//         var mutable = input
//         mutable += " Awesome Day."
//         return mutable
//     }

//     static func takeStringGiveString(input: String) -> String {
//         let copied = input
//         return copied
//     }

//     static func identity(input: String) -> String {
//         return input
//     }

// }
#include <string>
std::string identity(std::string input) {
return input;
}

std::string takeStringGiveString(std::string input) {
std::string copied = input;
return copied;
}
std::string takeStringMutateGiveString(std::string input) {
std::string m = input;
m += " Awesome Day.";
return m;
}

int main() {
    std::string greeting = "Hello World!";
    std::string a = takeStringGiveString(greeting);
    std::string b = takeStringMutateGiveString(greeting);
    std::string c = identity(greeting);
}