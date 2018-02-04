#include <stdio.h>

#define CHARS   128

/* print a histogram of the frequencies of different characters in input */
main()
{
    int c, i, max;
    int nchars[CHARS];

    for (i = 0; i < CHARS; ++i)
        nchars[i] = 0;
    while ((c = getchar()) != EOF)
        ++nchars[c];

    max = 0;
    for (i = 0; i < CHARS; ++i)
        if (nchars[i] > max)
            max = nchars[i];

    while (max > 0) {
        for (i = 0; i < CHARS; ++i)
            if (nchars[i] >= max)
                putchar('-');
            else
                putchar(' ');   
        putchar('\n');
        --max;
    }

    for (i = 0; i < CHARS; ++i)
        if (' ' <= i && i <= '~')
            putchar(i);
        else
            putchar('.');
    putchar('\n');
}
