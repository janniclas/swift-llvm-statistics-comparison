
#include <iostream>

using namespace std;
int switchMe(pair<int, int>input){
	int counter;
	switch (input)
	{
	case (int x, 0):
		counter = x;
		break;
	case (0, int y):
		counter = -y;
		break;
	case (int x, int y):
		counter = -x;
		break;
	default:
		counter = 42;
		break;
	}
	return counter;
}
int main(){
	pair<int, int>input;
	input.first = 2;
	input.second = 3;
	int res = switchMe(input);
	return 0;
}