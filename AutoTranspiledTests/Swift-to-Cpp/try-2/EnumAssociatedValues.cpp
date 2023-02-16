
// Enumerations similar to these are known as discriminated
// unions, tagged unions, or variants in other programming languages.
std::variant<std::tuple<int, int, int, int>, std::string> Barcode;

int strangeSum(Barcode code) {
	// Initial value set to 0   
    int x = 0;

    // Check the type of the variable
    if(auto number_system = std::get_if<0>(&code)){
        x = number_system->first + number_system->second + number_system->third + number_system->fourth;
    } else if(auto product_code = std::get_if<1>(&code)) {
        x = -1;
    }

    return x;
}

int main(){
	// Variable for main
	Barcode productBarcode = std::make_tuple(8, 85909, 51226, 3);
	int first = strangeSum(productBarcode);

	productBarcode = std::string("ABCDEFGHIJKLMNOP");
	int second = strangeSum(productBarcode);

	return 0;
}