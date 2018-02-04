#include <stdio.h>
#define MAXLINE 1000    /* maximum input line size */

int getline_(char line[], int maxline);

/* remove trailing blanks, tabs, and blank lines */
main()
{
    int len;
    char line[MAXLINE];

    while ((len = getline_(line, MAXLINE)) > 0) {
        if (line[len-1] == '\n')
            --len;
        while (line[len-1] == ' ' || line[len-1] == '\t') {
            line[len-1] = line[len];
            --len;
        }
        if (len < MAXLINE) {
            ++len;
            line[len] = '\0';
        }
        if (len > 1) /* more than just a '\n' */
            printf("%s", line);
    }
    return 0;
}

/* getline_: read a line into s, return length */
int getline_(char s[], int lim)
{
    int c, i;

    for (i=0; i<lim-1 && (c=getchar())!=EOF && c!='\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}

