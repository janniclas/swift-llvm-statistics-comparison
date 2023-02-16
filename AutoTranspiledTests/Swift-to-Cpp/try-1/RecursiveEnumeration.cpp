
 // A recursive enumeration is an enumeration that has another
 // instance of the enumeration as the associated value for
 // one or more of the enumeration cases. You indicate that an
 // enumeration case is recursive by writing indirect before it,
 // which tells the compiler to insert the necessary layer of indirection.

enum ArithmeticExpression {
    number,
    indirect addition,
    indirect multiplication,
};

int main() {
   ArithmeticExpression five = ArithmeticExpression::number;
   ArithmeticExpression four = ArithmeticExpression::number;
   ArithmeticExpression sum = ArithmeticExpression::addition;
   ArithmeticExpression product = ArithmeticExpression::multiplication;

   int result = evaluate(product);
   return 0;
}

int evaluate(ArithmeticExpression expression) {
    switch (expression) {
        case ArithmeticExpression::number:
            return value;
        case ArithmeticExpression::addition:
            return evaluate(left) + evaluate(right);
        case ArithmeticExpression::multiplication:
            return evaluate(left) * evaluate(right);
        default:
            return -1;
    }
}