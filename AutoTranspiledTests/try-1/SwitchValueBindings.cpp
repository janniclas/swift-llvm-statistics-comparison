
int main() {
	int res = switchMe((2, 3));
	return 0;
}

int switchMe(std::pair<int, int> input) {
	int counter = 0;
	int max = 7;
	switch(input) {
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
	}
	return counter;
}