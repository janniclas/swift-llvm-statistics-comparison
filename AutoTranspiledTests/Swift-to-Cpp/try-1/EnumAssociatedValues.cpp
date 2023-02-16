
enum Barcode
{
	upc_t(int, int, int, int),
	qrCode_t(std::string)
};

int strangeSum(const Barcode code)
{
	int x = 0;
	std::visit([&x](auto&& l)
				{
					using T = std::decay_t<decltype(l)>;
					if constexpr (std::is_same_v<T, upc_t>)
					{
						const auto& [numberSystem, manufacturer, product, check] = l;
						x = numberSystem + manufacturer + product + check;
					}
					else if constexpr (std::is_same_v<T, qrCode_t>)
					{
						const auto& [productCode] = l;
						x = -1;
					}
				},code);
	return x;
}

int main()
{
	Barcode productBarcode = Barcode::upc_t(8, 85909, 51226, 3);
	auto first = strangeSum(productBarcode);
	productBarcode = Barcode::qrCode_t("ABCDEFGHIJKLMNOP");
	auto second = strangeSum(productBarcode);
	return 0;
}