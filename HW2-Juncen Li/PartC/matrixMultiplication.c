#include <stdio.h>
#include <time.h>

int main() {
    int n = 1000;
    float a[1000][1000], b[1000][1000], c[1000][1000];
    
    // Initialize matrices
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            a[i][j] = (float)i * n + j;
            b[i][j] = (float)j * n + i;
        }
    }
    
    clock_t start = clock();
    
    // Multiply matrices
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            c[i][j] = 0;
            for (int k = 0; k < n; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
    
    clock_t end = clock();
    double duration = (double)(end - start) / CLOCKS_PER_SEC * 1000;
    
    printf("Matrix multiplication took %.0f milliseconds.\n", duration);
    
    return 0;
}
