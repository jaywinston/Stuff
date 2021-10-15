#include <stdio.h>

void main()
{
  int i, c, lim=1000;
  char line[lim];

  for (i=0; i<lim-1; ++i)
    if ((c=getchar()) == '\n')
      lim = --i;
    else if (c == EOF)
      lim = i;
    else
      line[i] = c;
  if (c == '\n') {
    line[i] = c;
    ++i;
  }
  line[i] = '\0';
  printf(line);
}
