 
#include<iostream>
using namespace std;
int main()
{
	string wiseWords = "\"Imagination is more important than knowledge\" - Einstein";
	string dollarSign = "\u0024"; // $; Unicode scalar U+0024
	string blackHeart = "\u2665" // ♥; Unicode scalar U+2665
	string sparklingHeart = "\u1F496"; // 💖; Unicode scalar U+1F496

	cout << wiseWords;
	cout << dollarSign;
	cout << blackHeart;
	cout << sparklingHeart;

	return 0;
}