
#include <iostream>

using namespace std;
int switchMe(pair<int, int>input){
	int counter = 0;
	if (input.second == 0) {
		int x = input.first;
		counter = x;
	} else if (input.first == 0) {
		int y = input.second;
		counter = -y;
	} else if (input.first == input.second) {
		int x = input.first;
		counter = -x;
	} else {
		counter = -1;
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