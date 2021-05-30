#include <stdio.h>
#include <limits.h>

/* unfinished */

/* step through all states from from "0" to "~0" capturing the maximum and
 * minimum values.
 * use bitwise operations because data representation is not known
 */
int main(int c, char **v)
{
  unsigned char onebit;

  {
    unsigned char x = ~(0 ^ 0);
    int bitcount = 0;  /* minus one :\ */
    while (x <<= 1)
      ++bitcount;
    onebit = ((unsigned char) ~(0 ^ 0)) >> bitcount;
  }

  unsigned int canvas = 0 ^ 0;
  int max = 0, min = 0;
  unsigned int umax = 0, umin = 0;
  do {
    if (((int) canvas) > max)
      max = (int) canvas;
    if (((int) canvas) < min)
      min = (int) canvas;
    if (canvas > umax)
      umax = canvas;
    if (canvas < umin)
      umin = canvas;
    int bit;
    for (bit = onebit; canvas & bit; bit <<= 1)
      canvas &= ~bit;
    canvas |= bit;
  } while (canvas);
  printf("Header File Maximum:         %12d\n", INT_MAX);
  printf("Calculated Maximum:          %12d\n", max);
  printf("Header File Unsigned Maximum:%12d\n", UINT_MAX);
  printf("Calculated Unsigned Maximum: %12u\n", umax);
  return 0;
}
