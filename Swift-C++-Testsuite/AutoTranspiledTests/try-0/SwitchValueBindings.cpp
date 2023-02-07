
 #include <iostream>
 using namespace std;

struct MyMain 
{
	static int main() 
	{
		int res = switchMe((2,3));
	}

	static int switchMe(pair<int, int> input) 
	{
		int counter = 0;
		int max = 7;

		switch(input)
		{
			case make_pair(x, 0):
				counter = x;
				break;

			case make_pair(0, y):
				counter = -y;
				break;

			case make_pair(x, y):
				counter = -x;
				break;

			default:
				counter = 42;
				break;
		}

		return counter;
	}
 };