
#include<iostream>
#include<string>
using namespace std;

struct MyMain{
	static string takeStringGiveString(string input){
		string copied = input;
		return copied;
	}

	static string takeStringMutateGiveString(string input){
		string m = input;
		m += " Awesome Day.";
		return m;
	}

	static string identity(string input){
		return input;
	}

	static void main(){
		string greeting = "Hello World!";
		string a = takeStringGiveString(greeting);
		string b = takeStringMutateGiveString(greeting);
		string c = identity(greeting);
	}
};

int main(){
	MyMain::main();
	return 0;
} 
# End