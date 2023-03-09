struct FooBase {
  virtual void foo(int **v, int *w) = 0;
};

struct Foo : FooBase {
  void foo(int **v, int *w) override { *v = w; }
};

struct FooDerived : FooBase {
  void foo(int **v, int *w) override {}
};

void callCB(FooBase *F, int **v, int *w) { F->foo(v, w); }

int bar() {
  int x = 42;
  int *y = nullptr;
  Foo F{};
  callCB(&F, &y, &x);
  return *y; // should return 42
}
