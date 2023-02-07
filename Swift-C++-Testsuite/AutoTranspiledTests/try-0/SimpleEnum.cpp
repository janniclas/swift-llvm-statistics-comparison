
enum CompassPoint {
    North,
    South,
    East,
    West
};

int main() {
    int x = 0;
    CompassPoint first = East;
    CompassPoint second = North;

    int first_result = wayfinder(first);
    int second_result = wayfinder(second);
    
    return 0;
}

int wayfinder(CompassPoint direction) {
    int x = 0;
    switch (direction) {
    case North: 
        x += 1;
        break;
    case South:
        x += 2;
        break;
    case East:
        x += 3;
        break;
    case West:
        x += 412;
        break;
    }
    return x;
}