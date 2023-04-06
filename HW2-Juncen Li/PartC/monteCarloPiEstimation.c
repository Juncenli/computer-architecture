#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main() {
    int n = 100000000;
    int inside = 0;
    
    srand48(0);
    
    clock_t start = clock();
    
    // Estimate Pi using Monte Carlo method
    for (int i = 0; i < n; i++) {
        double x = drand48();
        double y = drand48();
        if (x * x + y * y <= 1) {
            inside++;
        }
    }
    
    clock_t end = clock();
    double duration = (double)(end - start) / CLOCKS_PER_SEC * 1000;
    
    double pi = 4.0 * inside / n;
    printf("Estimated Pi: %f\n", pi);
    printf("Pi estimation took %.0f milliseconds.\n", duration);
    
    return 0;
}
