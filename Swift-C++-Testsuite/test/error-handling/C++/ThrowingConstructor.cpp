struct S {
  int data;
  S(int data) : data(data) {}
};

int main() {
  S *s = new S(0);
  return 0;
}