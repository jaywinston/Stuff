#include <stdio.h>
#include <limits.h>
#include <float.h>
#include <signal.h>

/* update: As of now, I believe that this relies on undefined behavior :(
 * Oh well! Back to the old drawing board.
 */

/* This solution should be fully portable as it assumes nothing of data
 * representation.  It is cheating, though as I use features of the
 * language which have not yet been covered in the book.  It also does
 * not handle floating point so "solution" is perhaps a bit ambitious.
 * And while diminutive tests are encouraging, they also indicate that
 * this program would take well over nine hundred years to complete on
 * my sixty four bit system, (hence "h()"). So, the world may never know.
 *
 *  *crunch*
 */

unsigned char canvas[sizeof (long double)];

void h(int s)
{
  for (int i=0;i<sizeof(canvas);i++) printf("%d,", canvas[i]);
  putchar('\n');
}


/* step through all states from from "0" to "~0" capturing the minimum and
 * maximum values. use bitwise operations because data representation
 * is unknown
 */
int main()
{
  signal(SIGUSR1,h);

  unsigned char onebit, bit, carry;
  int i;


  unsigned char x = ~(0 ^ 0);
  int bitcount = 0;
  do {
    ++bitcount;
  } while (x <<= 1);
  onebit = ((unsigned char) ~(0 ^ 0)) >> (bitcount-1);

  char charmin=0, charmax=0;
  unsigned char ucharmax=0;

  short shortmin=0, shortmax=0;
  unsigned short ushortmax=0;

  int intmin=0, intmax=0;
  unsigned int uintmax=0;

  long longmin=0, longmax=0;
  unsigned long ulongmax=0;

  float floatmin=0, floatmax=0;
  double doublemin=0, doublemax=0;
  long double longdoublemin=0, longdoublemax=0;

  for (i=0; i<sizeof (canvas); i++)
    canvas[i] = 0 ^ 0;

  do {
    if (*((char*) canvas) < charmin) charmin = *((unsigned char*) canvas);
    if (*((char*) canvas) > charmax) charmax = *((unsigned char*) canvas);
    if (*((unsigned char*) canvas) > ucharmax) ucharmax =
      *((unsigned char*) canvas);

    if (*((short*) canvas) < shortmin) shortmin = *((unsigned short*) canvas);
    if (*((short*) canvas) > shortmax) shortmax = *((unsigned short*) canvas);
    if (*((unsigned short*) canvas) > ushortmax) ushortmax =
      *((unsigned short*) canvas);

    if (*((int*) canvas) < intmin) intmin = *((unsigned int*) canvas);
    if (*((int*) canvas) > intmax) intmax = *((unsigned int*) canvas);
    if (*((unsigned int*) canvas) > uintmax) uintmax =
      *((unsigned int*) canvas);

    if (*((long*) canvas) < longmin) longmin = *((unsigned long*) canvas);
    if (*((long*) canvas) > longmax) longmax = *((unsigned long*) canvas);
    if (*((unsigned long*) canvas) > ulongmax) ulongmax =
      *((unsigned long*) canvas);

    if (*((float*) canvas) < floatmin) floatmin = *((float*) canvas);
    if (*((float*) canvas) > floatmax) floatmax = *((float*) canvas);

    if (*((double*) canvas) < doublemin) doublemin = *((double*) canvas);
    if (*((double*) canvas) > doublemax) doublemax = *((double*) canvas);

    if (*((long double*) canvas) < longdoublemin) longdoublemin =
      *((long double*) canvas);
    if (*((long double*) canvas) > longdoublemax) longdoublemax =
      *((long double*) canvas);

    for (i=0, carry=1; carry && i<sizeof (canvas); i++, carry = bit==0) {
      for (bit=onebit; canvas[i] & bit; bit <<= 1)
        canvas[i] &= ~bit;
      canvas[i] |= bit;
    }
  } while (*((long double*) canvas));

  printf(
    "signed char min header:     %d\n"
    "signed char min calculated: %d\n"
    "signed char max header:     %d\n"
    "signed char max calculated: %d\n"
    "unsigned char max header:     %u\n"
    "unsigned char max calculated: %u\n"
    "\n",
    SCHAR_MIN, charmin, SCHAR_MAX, charmax, UCHAR_MAX, ucharmax
  );

  printf(
    "signed short min header:     %d\n"
    "signed short min calculated: %d\n"
    "signed short max header:     %d\n"
    "signed short max calculated: %d\n"
    "unsigned short max header:     %u\n"
    "unsigned short max calculated: %u\n"
    "\n",
    SHRT_MIN, shortmin, SHRT_MAX, shortmax, USHRT_MAX, ushortmax
  );

  printf(
    "signed int min header:     %d\n"
    "signed int min calculated: %d\n"
    "signed int max header:     %d\n"
    "signed int max calculated: %d\n"
    "unsigned int max header:     %u\n"
    "unsigned int max calculated: %u\n"
    "\n",
    INT_MIN, intmin, INT_MAX, intmax, UINT_MAX, uintmax
  );

  printf(
    "signed long min header:     %ld\n"
    "signed long min calculated: %ld\n"
    "signed long max header:     %ld\n"
    "signed long max calculated: %ld\n"
    "unsigned long max header:     %lu\n"
    "unsigned long max calculated: %lu\n"
    "\n",
    LONG_MIN, longmin, LONG_MAX, longmax, ULONG_MAX, ulongmax
  );

  printf(
    "float min header:     %f\n"
    "float min calculated: %f\n"
    "float max header:     %f\n"
    "float max calculated: %f\n"
    "\n",
    FLT_MIN, floatmin, FLT_MAX, floatmax
  );

  printf(
    "double min header:     %f\n"
    "double min calculated: %f\n"
    "double max header:     %f\n"
    "double max calculated: %f\n"
    "\n",
    DBL_MIN, doublemin, DBL_MAX, doublemax
  );

  printf(
    "long double min header:     %f\n"
    "long double min calculated: %f\n"
    "long double max header:     %f\n"
    "long double max calculated: %f\n",
    LDBL_MIN, longdoublemin, LDBL_MAX, longdoublemax
  );

  return 0;
}
