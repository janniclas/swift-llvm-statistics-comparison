 
#include <iostream>

using namespace std;

struct MyMain
{
	static int identity(int x)
	{
		if (x == 0)
		{
			return x;
		}
		return NULL;
	}
	
};

int main()
{
	int myNil = MyMain::identity(42); 
	int myIdentity = MyMain::identity(0);
	return 0;
}