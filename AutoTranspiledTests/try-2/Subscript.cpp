
#include <iostream>
#include <assert.h>
 
class Matrix {
    int rows;
    int columns;
    double *grid;

public:
    Matrix(int r, int c) {
        rows = r;
        columns = c;
        grid = new double[rows * columns]();
    }

    ~Matrix() {
        delete[] grid;
    }

    bool indexIsValid(int row, int col) {
        return row >= 0 && row < rows && col >= 0 && col < columns;
    }

    double get(int row, int col) {
        assert(indexIsValid(row, col));
        return grid[row * columns + col];
    }

    void set(int row, int col, double newValue) {
        assert(indexIsValid(row, col));
        grid[row * columns + col] = newValue;
    }
};

int main() {
    Matrix matrix(2, 2);
    matrix.set(0, 1, 1.5);
    matrix.set(1, 0, 3.2);
    return 0;
}