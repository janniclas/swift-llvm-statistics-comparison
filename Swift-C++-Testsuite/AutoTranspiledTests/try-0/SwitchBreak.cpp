
int switchMe(std::pair<int, int> input) {
  int counter = 0;
  int max = 7;
  switch(input) {
    case std::make_pair(x, 0):
      break;
    case std::make_pair(0, y):
      counter = -y;
      break;
    case std::make_pair(x, y):
      counter = -x;
      break;
    default:
      counter = 42;
      break;
  }
  return counter;
}

int main() {
  int res = switchMe(std::make_pair(2, 3));
  return 0;
}