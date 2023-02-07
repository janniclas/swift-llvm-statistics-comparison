
 #include <iostream>

int switchMe(std::pair<int, int> input)
{
  int counter = 0;
  int max = 7;
  switch (input) {
	case (std::pair<int, int>(let x, 0)):
		counter = x;
		break;
	case (std::pair<int, int>(0, let y)):
		counter = -y;
		break;
	case (let (x, y)):
		if (x == y)
			counter = -x;
    break;
	default:
		counter = -1;
		break;
	}
	return counter;
}
	
int main() {
  std::pair<int, int> input(2, 3);
  int res = switchMe(input);
}
 # End