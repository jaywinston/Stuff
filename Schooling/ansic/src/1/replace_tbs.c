#include <stdio.h>

/* Exercise 10; copy input to output replacing each tab by \t, each backspace
    by \b, and each backslash by \\. */
main()
{
    int c;

    while ((c = getchar()) != EOF) {
        if (c == '\t')
            printf("\\t");
        if (c == '\b')
            printf("\\b");
        if (c == '\\')
            printf("\\");
        if (c != '\t')
            if (c != '\b')
                if (c != '\\')
                    putchar(c); 
        
    }
}
