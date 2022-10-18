#include <string>

// clang++ -std=c++20 Multiline.cpp
// no idea why, but clang++ needs the c++ 20 flag
// to compile this on a M1 MacBook.
int main() {
    // A Raw string
    const char * vogon_poem = R"V0G0N(
                O freddled gruntbuggly thy micturations are to me
                    As plured gabbleblochits on a lurgid bee.
                Groop, I implore thee my foonting turlingdromes.   
            And hooptiously drangle me with crinkly bindlewurdles,
    Or I will rend thee in the gobberwarts with my blurlecruncheon, see if I don't.

                    (by Prostetnic Vogon Jeltz; see p. 56/57)
    )V0G0N";
    return 0;
}