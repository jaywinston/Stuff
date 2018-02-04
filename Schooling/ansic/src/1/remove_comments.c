#include <stdio.h>

#define OUT 0
#define IN  1

/* Exercise 1-23; remove all comments from a C program */
main()
{
    char b;
    int c;
    int comment, string;

    b = '\0';
    comment = string = OUT;
    while ((c = getchar()) != EOF)
            if (comment == OUT)
                if (string == OUT)
                    if (c == '"') {
                        string = IN;
                        putchar(c);
                    }
                    else if (c == '/' && b != '/')
                        b = c;
                    else if (b == '/' && c == '*') {
                        comment= IN;
                        b = '\0';
                    }
                    else if (b == '/' && c != '*') {
                        putchar(b);
                        putchar(c);
                        b = '\0';
                    }
                    else
                        putchar(c);
                else {
                    if (c =='"')
                            string = OUT;
                    putchar(c);
                }
            else
                if (c == '*')
                    b = c;
                else if (b == '*' && c == '/') {
                    comment = OUT;
                    b = '\0';
                }
                else if (b == '*' && c != '/')
                b = '\0';
    return 0;
}

