#include <stdio.h>

#define n   4

/* replace tabs in input with the proper number of blanks to space to the
    next tabstop */
main()
{
    int c, i;

    i = 0;
    while ((c = getchar()) != EOF) {
        if (c == '\t')
            while (i < n) {
                putchar(' ');
                ++i;
            }
        else {
            putchar(c);
	    ++i;
	}
        if (i ==  n || c == '\n')
            i = 0;
    }
}

