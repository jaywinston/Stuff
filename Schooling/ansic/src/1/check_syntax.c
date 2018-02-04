#include <stdio.h>

#define OUT         0
#define STRING      1
#define STRESC      2
#define CHARACTER   3
#define CHARESC     4
#define COMMENT     5
#define HASHCMD     6
#define INCLUDE     7
#define FOREXPR     8

#define FALSE   0
#define TRUE    1
#define ERR     2

#define MAXSTR  80

int isesc(int);
int isspacel(char);
int isdelim(char);
int streq(char[], char[]);

/* Exercise 1-24: check a C program for rudimentary syntax errors */
void main()
{
    char buf[MAXSTR];
    int c, i;
    int nl, nc;
    int parens, braces, brackets;
    int rangle, langle, quotes;
    int forparens, forsemicolons;
    int state;
    int escape;
    int test;

    i = 0;
    nl = 1;
    nc = 0;
    parens = brackets = braces = 0;
    rangle = langle = quotes = 0;
    state = OUT;
    escape = test = '\0';
    while ((c = getchar()) != EOF) {
        if (c == '\n') {
            ++nl;
            nc = 0;
        }
        else if (c == '\t')
            nc = nc + 4;
        else
            ++nc;
        if (test == '/' && c == '*')
            state = COMMENT;
        else if (c == '#')
            state = HASHCMD;
        if (state == OUT || state == HASHCMD
            || state == INCLUDE || state == FOREXPR) {
            if (c == '(')
                ++parens;
            if (c == ')')
                --parens;
            if (c == '{')
                ++braces;
            if (c == '}')
                --braces;
            if (c == '[')
                ++brackets;
            if (c == ']')
                --brackets;
        }
        if (state == OUT)
            if (c == '"')
                state = STRING;
            else if (c == '\'')
                state = CHARACTER;
            else if (isdelim(c) == TRUE && streq(buf, "for") == TRUE) {
                state = FOREXPR;
                forparens = -1;
                forsemicolons = 2;
            }
            else if (c == ';') {
                if (parens > 0)
                    printf("unclosed parentheses before:  %d:%d\n", nl, nc);
                if (parens < 0)
                    printf("extra parentheses before:  %d:%d\n", nl, nc);
                if (brackets > 0)
                    printf("unclosed brackets before:  %d:%d\n", nl, nc);
                if (brackets < 0)
                    printf("extra brackets before:  %d:%d\n", nl, nc);
            }
            else if (isdelim(c) == FALSE) {
                buf[i] = c;
                buf[++i] = '\0';
            }
            else
                buf[i=0] = '\0';
        else if (state == STRING)
            if (c == '\\')
                state = STRESC;
            else if (c == '"')
                state = OUT;
            else
                ;
        else if (state == STRESC) {
            if (isesc(c) == FALSE)
                printf("invalid escape sequence:  %d:%d\n", nl, nc);
            state = STRING;
        }
        else if (state == CHARACTER)
            if (c == '\\')
                state = CHARESC;
            else if (c == '\'')
                state = OUT;
            else if (test != '\'')
                printf("unclosed single quote:  %d:%d\n", nl, nc);
            else
                ;
        else if (state == CHARESC) {
            if (isesc(c) == FALSE)
                printf("invalid escape sequence:  %d:%d\n", nl, nc);
            state = CHARACTER;
        }
        else if (state == COMMENT)
            if (test == '*' && c == '/')
                state = OUT;
            else
                ;
        else if (state == HASHCMD)
            if (streq(buf, "include") == TRUE) {
                state = INCLUDE;
                buf[i = 0] = '\0';
            }
            else if (c == '\n') {
                state = OUT;
                buf[i = 0] = '\0';
            }
            else {
                buf[i] = c;
                buf[++i] = '\0';
            }
        else if (state == INCLUDE)
            if (c == '<')
                ++langle;
            else if (c == '>')
                ++rangle;
            else if (c == '"')
                ++quotes;
            else if (c == '\n') {
                state = OUT;
                buf[i = 0] = '\0';
                if (langle > rangle)
                    printf("unmatched '<' in include command:  %d\n", nl);
                else if (langle < rangle)
                    printf("unmatched '>' in include command:  %d\n", nl);
                else if (quotes == 1)
                    printf("unmatched '\"' in include command:  %d\n", nl);
                else if (quotes > 2)
                    printf("excess '\"' found in include command:  %d\n", nl);
                else if (langle == 0 && rangle == 0 && quotes == 0)
                    printf("no file found in include command:  %d\n", nl);
            }
            else
                ;
        else if (state == FOREXPR)
            if (forsemicolons == 0 && forparens == 0 && c == ')') {
                state = OUT;
                buf[i=0] ='\0';
            }
            else if (c == '(')
                ++forparens;
            else if (c == ')')
                --forparens;
            else if (c == ';')
                --forsemicolons;
        test = c;
    }
    if (state == STRING)
        printf("unclosed string\n");
    if (state == COMMENT)
        printf("unclosed comment\n");
    if (braces > 0)
        printf("unclosed braces\n");
    if (braces < 0)
        printf("extra braces\n");
}

/* isesc: determine if c is a valid escape char */
int isesc(int c)
{
    if (c == '\"'
            || c == '%'
            || c == '\''
            || c == '('
            || c == '0'
            || c == '1'
            || c == '2'
            || c == '3'
            || c == '4'
            || c == '5'
            || c == '6'
            || c == '7'
            || c == '?'
            || c == 'U'
            || c == '['
            || c == '\\'
            || c == 'a'
            || c == 'b'
            || c == 'f'
            || c == 'n'
            || c == 'r'
            || c == 't'
            || c == 'u'
            || c == 'v'
            || c == 'x'
            || c == '{'
            || c == 'E'
            || c == 'e')
        return TRUE;
    return FALSE;
}

/* isspacel: check if c is a space, newline, or tab character; local version */
int isspacel(char c)
{
    if (c == ' ' || c == '\n' || c == '\t')
        return TRUE;
    return FALSE;
}

/* isdelim: check if c is delimiter */
int isdelim(char c)
{
    if (c == ' '
        || c == '\t'
        || c == '\n'
        || c == '='
        || c == '+'
        || c == '-'
        || c == '*'
        || c == '/'
        || c == '>'
        || c == '<'
        || c == '!'
        || c == '&'
        || c == '|'
        || c == '('
        || c == ')'
        || c == '{'
        || c == '}'
        || c == '['
        || c == ']'
        || c == ','
        || c == ';'
        || c == '\"'
        || c == '\''
        || c == '\\'
        || c == '#')
        return TRUE;
    return FALSE;
}

/* streq: determine if s and t are equal */
int streq(char s[], char t[])
{
    int i;

    for (i=0; i<MAXSTR && t[i]!='\0'; ++i)
        if (s[i] != t[i])
            return FALSE;
    if (t[i] == '\0' && s[i] != '\0')
        return FALSE;
    return TRUE;
}

