#include <type_traits>

using namespace std;
template<typename... Args>
double arithmeticMean(Args... args) {
    static_assert((is_same<double, Args>::value && ...), "All arguments must be of type double");
    double sum = (args + ...);
    return sum / sizeof...(args);
}


int main() {
    double res = arithmeticMean(3.2, 8.25, 18.75);
    
    return 0;
}