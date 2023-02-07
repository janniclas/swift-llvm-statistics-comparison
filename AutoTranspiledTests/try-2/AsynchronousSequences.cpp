 
#include <iostream>
#include <fstream>
#include <string>

int main () {

	string line;
	ifstream myfile ("input.txt");
	if (myfile.is_open())
	{
		while ( getline (myfile,line) )
		{
			cout << line << '\n';
		}
		myfile.close();
	}
	else {
		cout << "Unable to open file" << endl;
	}
	
 	return 0;
}