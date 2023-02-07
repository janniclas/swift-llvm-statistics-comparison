

#include <iostream>
#include <string>

int main(int argc, char *argv[])
{
    std::string wiseWords = R"("Imagination is more important than knowledge" - Einstein)";
    // "Imagination is more important than knowledge" - Einstein
    std::string dollarSign(u8"\u0024");  // $,  Unicode scalar U+0024
    std::string blackHeart(u8"\u2665");  // ♥,  Unicode scalar U+2665
    std::string sparklingHeart(u8"\u1F496");  // 💖, Unicode scalar U+1F496

    return 0;
}