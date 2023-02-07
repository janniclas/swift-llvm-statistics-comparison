
#include <iostream>
#include <string>
#include <map>

using namespace std;

map<string, string> favoriteSnacks = {
  {"Alice", "Chips"},
  {"Bob", "Licorice"},
  {"Eve", "Pretzels"}
};

struct Item
{
    int price;
    int count;
};
enum class VendingMachineError
{
    invalidSelection,
    insufficientFunds,
    outOfStock
};
class VendingMachine
{
public:
    map<string, Item> inventory =
        {{"Candy Bar",Item{12, 7}},
         {"Chips",Item{10, 4}},
         {"Pretzels",Item{7, 11}}
        };
    int coinsDeposited = 0;

    void vend(string name) noexcept(false)
    {
        auto item = inventory.find(name);
        if(item == inventory.end())
        {
            throw VendingMachineError::invalidSelection;
        }
        if(item->second.count == 0)
        {
            throw VendingMachineError::outOfStock;
        }
        if(item->second.price > coinsDeposited)
        {
            throw VendingMachineError::insufficientFunds;
        }
        coinsDeposited -= item->second.price;

        Item newItem = item->second;
        newItem.count--;
        inventory[name] = newItem;

        cout << "Dispensing " << name << endl;
    }
};

void buyFavoriteSnack(string person, VendingMachine &vendingMachine)
{
    string snackName = favoriteSnacks[person];
    if(snackName.empty()){
        snackName = "Candy Bar";
    }
    try {
        vendingMachine.vend(snackName);
        cout << "Success! Yum." << endl;
    } catch (VendingMachineError error) {
        switch (error)
        {
        case VendingMachineError::invalidSelection:
            cout << "Invalid Selection." << endl;
            break;
         case VendingMachineError::outOfStock:
            cout << "Out of Stock." << endl;
            break;
        case VendingMachineError::insufficientFunds:
            cout << "Insufficient funds. Please insert an additional coins." << endl;
            break;
        }
    }
}

int main()
{
    VendingMachine vm;
    vm.coinsDeposited = 8;
    buyFavoriteSnack("Alice", vm);
}