#include <stdio.h>

#define n   4

/* Exercise 1-21; replace strings of b by the minimum number of
    tabs and blanks to achieve the same spacing */
main()
{
    int c;
    int t, b;

    while ((c = getchar()) != EOF)
        if (c == ' ') {
            b = 1;
            while ((c = getchar()) == ' ')
                ++b;
            t = b / n;
            b = b - t * n;
            while (t > 0) {
                putchar('\t');
                --t;
            }
            while (b > 0) {
                putchar(' ');
                --b;
            }
            putchar(c);
        }
        else
            putchar(c);
}

