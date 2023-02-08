#include <iostream>
#include <vector>

using namespace std;

struct Matrix {
    int rows, columns;
    vector<double> grid;

    Matrix(int rows, int columns) : rows(rows), columns(columns) {
        grid.resize(rows * columns);
    }

    bool indexIsValid(int row, int column) {
        return row >= 0 && row < rows && column >= 0 && column < columns;
    }

    double& operator()(int row, int column) {

        return grid[row * columns + column];
    }

    const double& operator()(int row, int column) const {

        return grid[row * columns + column];
    }
};

int main() {
    Matrix matrix(2, 2);
    matrix(0, 1) = 1.5;
    matrix(1, 0) = 3.2;
    return 0;
}
