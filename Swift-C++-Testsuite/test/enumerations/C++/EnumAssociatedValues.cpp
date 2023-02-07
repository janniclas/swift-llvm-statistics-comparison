#include<variant>
#include<string>
#include<tuple>
#include <iostream>
using namespace std;

int strangeSum(std::variant<std::tuple<int, int, int, int>, std::string> code) {
	// Initial value set to 0   
    int x = 0;

    // Check the type of the variable
    if(auto number_system = std::get_if<0>(&code)){
        x = std::get<0>(*number_system) + std::get<1>(*number_system) + std::get<2>(*number_system) + std::get<3>(*number_system);
    } else if(auto product_code = std::get_if<1>(&code)) {
        x = -1;
    }

    return x;
}

int main(){
	// Variable for main
    std::variant<std::tuple<int, int, int, int>, std::string> productBarcode;
	
    productBarcode = std::make_tuple(8, 85909, 51226, 3);
	int first = strangeSum(productBarcode);

	productBarcode = std::string("ABCDEFGHIJKLMNOP");
	int second = strangeSum(productBarcode);

	return 0;
}