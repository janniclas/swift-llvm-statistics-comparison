
enum class ArithmeticExpression 
{ 
    number, 
    addition, 
    multiplication,
}; 

struct MyMain {
	int evaluate(struct ArithmeticExpression expression) 
	{ 
		switch (expression.type) 
		{ 
			case Enum::number: 
				return expression.value; 
			case Enum::addition: 
				return evaluate(expression.left) + 
					evaluate(expression.right); 
			case Enum::multiplication: 
				return evaluate(expression.left) * 
					evaluate(expression.right); 
		} 
	} 

	static void main() 
	{ 
		ArithmeticExpression five = { ArithmeticExpression::number, 5 }; 
		ArithmeticExpression four = { ArithmeticExpression::number, 4 }; 
		ArithmeticExpression sum = 
			{ ArithmeticExpression::addition, five, four }; 
		ArithmeticExpression product = { 
			ArithmeticExpression::multiplication, sum, 
				{ ArithmeticExpression::number, 5 } 
		}; 
		int result = evaluate(product); 
	} 
};