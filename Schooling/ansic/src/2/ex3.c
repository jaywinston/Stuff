#include <ctype.h>

int htoi(char s[])
{
  int acc = 0;
  int i = 0;
  char c;

  if (s[0] == '0') {
    ++i;
    if (s[1] == 'x' || s[1] == 'X')
      ++i;
  }

  for (; (c=s[i]) != '\0'; ++i)
    if (isdigit(c))
      acc += c - '0';
    else if (c == 'A' || c == 'a')
      acc += 10;
    else if (c == 'B' || c == 'b')
      acc += 11;
    else if (c == 'C' || c == 'c')
      acc += 12;
    else if (c == 'D' || c == 'd')
      acc += 13;
    else if (c == 'E' || c == 'e')
      acc += 14;
    else if (c == 'F' || c == 'f')
      acc += 15;

  return acc;
}

#include <stdio.h>
void main()
{
  char *s = "0xff";
  printf("%d %s\n", htoi(s), s); 
}
