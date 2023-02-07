
struct MyMain {

static void main() {
// search builtinStringLiteral.* in swift repository
// sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC
std::string greeting = "Hello World!";
std::string a = takeStringGiveString(input: greeting);
std::string b = takeStringMutateGiveString(input: greeting);
std::string c = identity(input: greeting);

}

// Behind the scenes, Swift’s compiler optimizes string usage so that actual
// copying takes place only when absolutely necessary. This means you always
// get great performance when working with strings as value types.
static std::string takeStringMutateGiveString(std::string input) {
std::string m = input;
m += " Awesome Day.";
return m;
}

static std::string takeStringGiveString(std::string input) {
std::string copied = input;
return copied;
}

static std::string identity(std::string input) {
return input;
}

};