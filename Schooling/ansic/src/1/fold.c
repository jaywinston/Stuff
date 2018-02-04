#include <stdio.h>
#define MAXLINE 1000    /* maximum input line size */
#define N   10

int getline_(char line[], int maxline);
int getfold(char s[], int n);
void copy(char to[], char from[]);
int nextword(char s[], int i);
int truncleft(char s[], int i, int len);

/* "fold" long input lines into two or more shorter lines after the last
    non-blank character before the n-th column */
main()
{
    int i, j;
    int len;
    char c;
    char line[MAXLINE];
    char fold[N];

    while ((len = getline_(line, MAXLINE)) > 0) {
        while (len > N) {
            c = 0;
            i = getfold(line, N);
            if (line[i] != ' ' && line[i] != '\t')
                c = line[i];
            line[i] = '\0';
            copy(fold, line);
            printf("%s\n", fold);
            if (c != 0)
                line[i] = c;
            else
                i = nextword(line, i+1);
            len = len - i;
            j = truncleft(line, i, len);
            line[j] = '\0';
        }
        if (len > 0)
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

/* getfold: get the index of where to fold s before n */
int getfold(char s[], int n)
{
    while (s[n] != ' ' && s[n] != '\t' && n > 0)
         --n;
    if (n > 0) {
        while (s[n] == ' ' || s[n] == '\t' && n > 0)
            --n;
        if (s[n] != ' ' && s[n] != '\t')
            ++n;
    }
    if (n == 0)
        n = N;
    return n;
}

/* copy: copy 'from' into 'to'; assume to is big enough */
void copy(char to[], char from[])
{
    int i;

    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}

/* nextword: return the index of the beginning of the next word after
    a string of blanks or tabs */
int nextword(char s[], int i)
{
    while (s[i] == ' ' || s[i] == '\t')
        ++i;
    return i;
}

/* truncleft: truncate i chars from the left of s */
int truncleft(char s[], int i, int len)
{
    int j;

    for (j = 0; j < len; j++)
        s[j] = s[j+i];
    return j;
}

