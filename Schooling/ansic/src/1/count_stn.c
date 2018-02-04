#include <stdio.h>

/* count blanks (spaces), tabs, and newlines */
main()
{
    int c, ns, nt, nl;

    ns = 0;
    nt = 0;
    nl = 0;
    while ((c = getchar()) != EOF) {
        if (c == ' ')
            ++ns;
        if (c == '\t')
            ++nt;
        if (c == '\n')
            ++nl;
    }
    printf("%d %d %d\n", ns, nt, nl);
}
