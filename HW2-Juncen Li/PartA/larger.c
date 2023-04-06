int larger(int x, int y) {
    if (x == y) {
        return 0;
    } 
    else if (x < y) {
        return y;
    }
    return x;
}

int main() {
    int x = 5;
    int y = 10;
    int result = larger(x, y);
    return result;
}