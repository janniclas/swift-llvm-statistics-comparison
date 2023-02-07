 
enum class Barcode {  //TODO: std::variants + tuples
    upc, qrCode
};
#include <tuple>

struct Foo{
    int numberSystem;
    int manufacturer;
    int product;
    int check;
    std::string productCode;
};

int main(){
    Barcode barcode = Barcode::upc;
    Foo productBarcode = {8, 85909, 51226, 3};
    int first = strangeSum(barcode, productBarcode);
    barcode = Barcode::qrCode;
    productBarcode = {0, 0, 0, 0, "ABCDEFGHIJKLMNOP"};
    int second = strangeSum(barcode, productBarcode);
}

int strangeSum(Barcode code, Foo foo){
    int x = 0;
    if (code == Barcode::upc){
        x = foo.numberSystem + foo.manufacturer + foo.product + foo.check;
    }else if (code == Barcode::qrCode){
        x = -1;
    }
    return x
}