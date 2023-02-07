
 #include <iostream>
 
 int main() 
 { 
	int finalSquare = 25; 
	int board[26]; 
	board[3]= 8;
	board[6]= 11;
	board[9]= 9;
	board[10]= 2;
	board[14]= -10;
	board[19]= -11;
	board[22]= 2;
	board[24]= 8;
	
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
			square += board[square]; 
		} 
		
	} 
	
	return 0; 
}