
 #include <iostream>
 
 int main() 
 { 
	int finalSquare = 25; 
	int board[3][3]; 
	board[3][0]= +08;
	board[3][1]= +11;
	board[3][2]= +09;
	board[4][0]= +02;
	board[4][1]= -10;
	board[4][2]= -11;
	board[5][0]= -02;
	board[5][1]= -08;
	
	int square = 0; 
	int diceRoll = 0; 
	
	while(square != finalSquare) 
	{ 
		diceRoll++; 
		if (diceRoll == 7) 
			diceRoll = 1; 
		
		if (square + diceRoll == finalSquare) 
			break; 
		
		if (square + diceRoll > finalSquare) 
			continue; 
		
		else
		{ 
			square += diceRoll; 
			square += board[square/3][square%3]; 
		} 
		
	} 
	
	return 0; 
}