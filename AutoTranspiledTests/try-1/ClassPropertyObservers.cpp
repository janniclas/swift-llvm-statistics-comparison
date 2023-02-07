
struct StepCounter {
    private:
    int totalSteps;
    public:
    int getTotalSteps()
    {
        return this->totalSteps;
    }
    void setTotalSteps(int x)
    {
        int oldValue = this->totalSteps;
        this->totalSteps = x;
        std::cout << "Total Steps Updated from: " <<  oldValue << " to: " << x << std::endl;
        if (totalSteps > oldValue)
        {
            std::cout << "Added " << (x - oldValue) << " Steps\n"; 
        } 
    }
};

int main() {
    StepCounter obj;
    obj.setTotalSteps(200);
    return 0;
}