#include <stdio.h>
#define MAXLINE 1000    /* maximum input line size */

int getline_(char line[], int maxline);
void reverse(char s[]);

/* print longest input line */
main()
{
    char line[MAXLINE];     /* current input line */

    while (getline_(line, MAXLINE) > 0) {
        reverse(line);
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

/* revers: reverse the character string s */
void reverse(char s[])
{
    int i, j;
    char tmp;

    j = 0; 
    while (s[j] != '\0')
        ++j;
    --j;
    for (i = 0; i < j; ++i) {
        tmp = s[i];
        s[i] = s[j];
        s[j] = tmp;
        --j;
    }
}
