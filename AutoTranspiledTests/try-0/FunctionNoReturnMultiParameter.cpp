
void paramNoReturn(int x, bool t) {
    if (t) {
        int a = 5;
        int b = 10;
        int c = a + b + x;
    }
}

int main() {
    paramNoReturn(42, true);
    return 0;
}