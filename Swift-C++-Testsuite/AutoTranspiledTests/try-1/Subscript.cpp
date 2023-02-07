
#include <cassert>
#include <iostream>
#include <vector>

struct Matrix {
  int rows;
  int columns;
  std::vector<double> grid;
  Matrix(int rows, int columns) {
    this->rows = rows;
    this->columns = columns;
    this->grid = std::vector(rows * columns, 0.0);
  }
  bool indexIsValid(int row, int column) {
    return row >= 0 && row < rows && column >= 0 && column < columns;
  }
  double& operator()(int row, int column) {
    assert(indexIsValid(row, column), "Index out of range");
    return grid[(row * columns) + column];
  }
};

int main() {
  Matrix matrix(2, 2);
  matrix(0, 1) = 1.5;
  matrix(1, 0) = 3.2;
  return 0;
}