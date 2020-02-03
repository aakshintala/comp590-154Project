#include <stdio.h>

// Dik T. Winter

int main(int argc, char* argv[]) {
    int digits;
    int r[2800 + 1];
    int i, k;
    int b, d;
    int c = 0;

    if (argc != 2) {
        fprintf(stderr, "Must provide an integer number of digits as argument!\n");
        return -1;
    }

    digits = 0;
    while(*argv[1]) {
      digits *= 10;
      digits += (*argv[1]-'0');
      ++(argv[1]);
    }

    if (digits < 1 || digits > 2000) {
        fprintf(stderr, "Number of digits must be between 1 and 2000!\n");
        return -1;
    }

    for (i = 0; i < digits; i++) {
        r[i] = 2000;
    }

    for (k = digits; k > 0; k -= 14) {
        d = 0;

        i = k;
        for (;;) {
            d += r[i] * 10000;
            b = 2 * i - 1;

            r[i] = d % b;
            d /= b;
            i--;
            if (i == 0) break;
            d *= i;
        }
        printf("%.4d", c + d / 10000);
        c = d % 10000;
    }
    printf("\n");

    return 0;
}
