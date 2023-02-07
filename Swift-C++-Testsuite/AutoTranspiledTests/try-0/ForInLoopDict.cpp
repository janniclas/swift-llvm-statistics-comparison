
 #include <iostream>
 #include <map>
 
int main() 
{
    std::map<int, int> a = { {1,2}, {2,3}, {3,4}, {4,5}, {5,6} };
    int sum = 0;
 
    for (const auto& b : a ) 
    {
            sum += (b.first + b.second);
    }
}