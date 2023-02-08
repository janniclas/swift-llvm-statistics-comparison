
struct Cuboid {
    double width = 0.0, height = 0.0, depth = 0.0;
    double volume() {
        return width * height * depth;
    }
};

int main() {
    Cuboid fourByFiveByTwo = { 4.0, 5.0, 2.0 };
    double computeMe = fourByFiveByTwo.volume();
    return 0;
}