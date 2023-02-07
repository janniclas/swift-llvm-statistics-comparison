
 struct MyMain 
{
	static int main()
	{
		int res = switchMe((2, 3));
		return res;
	}

	static int switchMe(pair<int, int>input)
	{
		int counter = 0;
		int max = 7;
		switch (input)
		{
			case make_pair(1, 1):
				counter = max;
				break; 
			case make_pair(0, 1):
				counter = -max;
				break; 
			case make_pair(0, _):
				counter = -max;
				break; 
			default: 
				counter = 42;
				break;		
		}
		return counter; 
	}
};