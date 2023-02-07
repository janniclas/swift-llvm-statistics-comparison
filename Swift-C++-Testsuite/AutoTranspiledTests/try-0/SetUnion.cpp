 
#include<iostream>
#include<set>
 
int main(){

    std::set<int> oddDigits{1, 3, 5, 7, 9};
    std::set<int> evenDigits{0, 2, 4, 6, 8};
    // Merge the set so that it contains odd and even digits
    oddDigits.insert(evenDigits.begin(),evenDigits.end());
 
    // Printing the merged set
    std::cout<<"Set contains :";
    for( auto itr=oddDigits.begin();itr!=oddDigits.end();itr++)
    std::cout<<*itr<<" ";
 
    return 0;
}