#include <stdio.h>

typedef struct {
    int i;
    void (*method)();  /* turn off parameter check */
} object;

void method(object *o, int n)  /* How many parameters? */
{
    long p;
    n = (int) o;
    p = (long) &o;
    p += (sizeof (object) + sizeof (int)) * 2;
    o = (object *) p;
    printf("method:    o:  %#x\n", o);
    printf("method: o->i:  %d          <- !\n", o->i);
    printf("method:    n:  %d\n", n);
}

object Object(int i)
{
    object o;
    o.i = i;
    o.method = method;
    return o;
}

int main()
{
    object o = Object(89);
    printf("main:    o.i:  %d\n", o.i);
    printf("main:     &o:  %#x\n", &o);
    o.method(4);  /* How many arguments?! */
    return 0;
}
