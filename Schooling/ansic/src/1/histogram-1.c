#include <stdio.h>

#define IN  0
#define OUT 1

/* print a histogram of lengths of words in input */
main()
{
    int c, i, max, state;
    int lwords[1000];

    state = OUT;
    for (i = 0; i < 1000; ++i)
        lwords[i] = 0;
    i = 0;
    while ((c = getchar()) != EOF)
        if (c != ' ' && c != '\n' && c != '\t') {
            state = IN;
            ++lwords[i];
        }
        else if (state ==  IN) {
            state = OUT;
            ++i;
        }

    max = 0;
    for (i = 0; i < 1000; ++i)
        if (lwords[i] > max)
            max = lwords[i];

    while (max > 0) {
        for (i = 0; lwords[i] > 0; ++i)
            if (lwords[i] >= max)
                putchar('-');
            else
                putchar(' ');   
        putchar('\n');
        --max;
    }
}
