
enum CompassPoint
{
    north,
    south,
    east,
    west
};
 
int wayfinder(CompassPoint direction)
{
    int x = 0;
    switch (direction)
    {
    case north:
        x += 1;
        break;
    case south:
        x += 2;
        break;
    case east:
        x += 3;
        break;
    case west:
        x += 412;
        break;
    }
    return x;
}
 
int main()
{
    int first = wayfinder(east);
    int second = wayfinder(north);
 
    return 0;
}