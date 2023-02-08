

int identity(int x, bool t) {
	if (t) {
		return x;
	}
	else {
		return -x;
	}
}

int main() {
int myRes = identity(42, true);
}