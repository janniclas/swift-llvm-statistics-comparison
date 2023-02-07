 
enum class ArithmeticExpression {
    number, addition, multiplication
}

struct Data {
    int value;
    ArithmeticExpression ae;
    Data* left;
    Data* right;
};

int evaluate(Data* expression) {
    switch (expression->ae) {
    case ArithmeticExpression::number:
        return expression->value;
    case ArithmeticExpression::addition:
        return evaluate(expression->left) + evaluate(expression->right);
    case ArithmeticExpression::multiplication:
        return evaluate(expression->left) * evaluate(expression->right);
    }
}

int main() {
    Data five;
    five.value = 5;
    five.ae = ArithmeticExpression::number;

    Data four;
    four.value = 4;
    four.ae = ArithmeticExpression::number;

    Data sum;
    sum.ae = ArithmeticExpression::addition;
    sum.left = &five;
    sum.right = &four;

    Data product;
    product.ae = ArithmeticExpression::multiplication;
    product.left = &sum;
    product.right = &five; // or any other number

    int result = evaluate(&product);

    return 0;
}