#include <stdio.h>
#include <limits.h>
#include <float.h>

int power(int, int);

int main ()
{
    char c;
    unsigned char uc;
    short s;
    unsigned short us;
    int i;
    unsigned int ui;
    long l;
    unsigned long ul;
    float f;
    double d;
    long double ld;

    printf("From headers\n============\n");
    printf("char signed %20d, %d\n", SCHAR_MIN, SCHAR_MAX);
    printf("char unsigned max %19d\n", UCHAR_MAX);
    printf("short signed %17d, %d\n", SHRT_MIN, SHRT_MAX);
    printf("short unsigned max %18u\n", USHRT_MAX);
    printf("int signed %14d, %d\n", INT_MIN, INT_MAX);
    printf("int unsigned max %20u\n", UINT_MAX);
    printf("long signed %13ld, %ld\n", LONG_MIN, LONG_MAX);
    printf("long unsigned max %19u\n", ULONG_MAX);
    printf("float %13lf, %lf\n", FLT_MIN, FLT_MAX);
    printf("double %13lf, %lf\n", DBL_MIN, DBL_MAX);
    printf("long double %19lf, %lf\n", LDBL_MIN, LDBL_MAX);
    putchar('\n');

    printf("Calculated\n==========\n");

    c = power(2, 7);
    printf("char signed %d, %d\n", c, -c+1);
    printf("char unsigned max %19d\n", UCHAR_MAX);
    printf("short signed %10d .. %10d\n", SHRT_MIN, SHRT_MAX);
    printf("short unsigned max %18u\n", USHRT_MAX);
    printf("int signed %12d .. %d\n", INT_MIN, INT_MAX);
    printf("int unsigned max %20u\n", UINT_MAX);
    printf("long signed %ld .. %ld\n", LONG_MIN, LONG_MAX);
    printf("long unsigned max %19u\n", ULONG_MAX);
}

/* power: raise base to the nth power */
int power(int base, int n)
{
    int p;

    for (p = 1; n > 0; --n)
        p = p * base;
    return p;
}
