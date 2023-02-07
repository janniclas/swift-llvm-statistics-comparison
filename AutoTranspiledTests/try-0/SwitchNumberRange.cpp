
 #include<iostream>
 
 struct MyMain 
{
  static void main() 
	{
		int res = switchMe(1);
		std::cout << res << std::endl;
	}

	static int switchMe(int input)
	{
		int counter = 0;
		int max = 7;
		switch(input)
		{
			case 1 ... 4 :
			counter = max;
			break;
			case 0 :
			counter = -max;
			break;
			default:
			counter = 42;
			break;
		}
		return counter;
	}
};
int main() 
{ 
  MyMain::main();
  return 0;
}