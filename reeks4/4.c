#include<stdio.h>

int kleinste(int a, int b, int c) {
    if (a <= b) {
        if (c <= a) {
            return c;
        }
        else {
            return a;
        }
    }
    return kleinste(b, a, c);
}

int main() {
    printf("%d", kleinste(3, 10, 20));
    return 0;
}