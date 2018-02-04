#include <stdio.h>

/* Exercise 9; copy input to output replacing each string of one or more blanks
    by a single blank */
main()
{
    int c;

    while ((c = getchar()) != EOF) {
        putchar(c); 
        if (c == ' ') {
            while ((c = getchar()) == ' ')
                ;
            if (c != EOF)
                putchar(c); 
        }
    }
}
