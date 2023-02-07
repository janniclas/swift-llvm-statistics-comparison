
@main
struct MyMain {

    static void main() {
        Matrix matrix(2, 2);
        matrix(0, 1) = 1.5;
        matrix(1, 0) = 3.2;
    }
};

class Matrix {
private:
  const int rows, columns;
  double* grid;

public:
  Matrix(int r, int c) : rows(r), columns(c), grid(new double[r * c]) {}
  double operator()(int row, int col) {
    if (row >= 0 && row < rows && col >= 0 && col < columns)
      return grid[row * columns + col];
  }
  double& operator()(int row, int col) {
    if (row >= 0 && row < rows && col >= 0 && col < columns)
      return grid[row * columns + col];
  }
};
# End