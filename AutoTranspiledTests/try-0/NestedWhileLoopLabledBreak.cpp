
 #include <iostream>
 
int main() {
    int counter = 0;
    int max = 12;

    while (counter < max)
    {
        counter += 1;

        switch (counter)
        {
        case 1 ... 4:
            continue;
        default:
            break;
        }
    }

    std::cout << counter << std::endl;
    
    return 0;
}