#include <stdio.h>
#include <limits.h>
#include <float.h>


int minn(int size)
{
    return 1 << size * 8 - 1;
}


int maxn(int size)
{
    return ~minn(size);
}


int main ()
{
    printf("From \"limits.h\"\n============\n");
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

    /* I don't know how this can be calculated without
       knowledge of the machine's architecture. */

    printf("char signed %d, %d\n", maxn(sizeof (char)), minn(sizeof (char)));
    printf("char unsigned max %19d\n", maxn(sizeof (unsigned char)));
    printf("short signed %10d .. %10d\n", maxn(sizeof (short)), minn(sizeof (short)));
    printf("short unsigned max %18u\n", maxn(sizeof (unsigned short)));
    printf("int signed %12d .. %d\n", maxn(sizeof (int)), minn(sizeof (int)));
    printf("int unsigned max %20u\n", maxn(sizeof (unsigned int)));
    printf("long signed %ld .. %ld\n", maxn(sizeof (long)), minn(sizeof (long)));
    printf("long unsigned max %19u\n", maxn(sizeof (unsigned long)));
}
