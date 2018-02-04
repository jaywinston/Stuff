#include <stdio.h>

/* Exercise 1-2; what happens when printf's argument string contains \c
    where c is some character not listed above
    Commented lines are not recognized by gcc as escape characters
    except for `U', `u', and `x' which need an argument */
main()
{
/*  printf("X' '\ Y\n");  */
/*  printf("X'!'\!Y\n");  */
    printf("X'\"'\"Y\n");
/*  printf("X'#'\#Y\n");  */
/*  printf("X'$'\$Y\n");  */
    printf("X'%'\%Y\n");
/*  printf("X'&'\&Y\n");  */
    printf("X'''\'Y\n");
    printf("X'('\(Y\n");
/*  printf("X')'\)Y\n");  */
/*  printf("X'*'\*Y\n");  */
/*  printf("X'+'\+Y\n");  */
/*  printf("X','\,Y\n");  */
/*  printf("X'-'\-Y\n");  */
/*  printf("X'.'\.Y\n");  */
/*  printf("X'/'\/Y\n");  */
    printf("X'0'\0Y\n"); 
    printf("X'1'\1Y\n");
    printf("X'2'\2Y\n");
    printf("X'3'\3Y\n");
    printf("X'4'\4Y\n");
    printf("X'5'\5Y\n");
    printf("X'6'\6Y\n");
    printf("X'7'\7Y\n");
/*  printf("X'8'\8Y\n");  */
/*  printf("X'9'\9Y\n");  */
/*  printf("X':'\:Y\n");  */
/*  printf("X';'\;Y\n");  */
/*  printf("X'<'\<Y\n");  */
/*  printf("X'='\=Y\n");  */
/*  printf("X'>'\>Y\n");  */
    printf("X'?'\?Y\n");
/*  printf("X'@'\@Y\n");  */
/*  printf("X'A'\AY\n");  */
/*  printf("X'B'\BY\n");  */
/*  printf("X'C'\CY\n");  */
/*  printf("X'D'\DY\n");  */
/*  printf("X'F'\FY\n");  */
/*  printf("X'G'\GY\n");  */
/*  printf("X'H'\HY\n");  */
/*  printf("X'I'\IY\n");  */
/*  printf("X'J'\JY\n");  */
/*  printf("X'K'\KY\n");  */
/*  printf("X'L'\LY\n");  */
/*  printf("X'M'\MY\n");  */
/*  printf("X'N'\NY\n");  */
/*  printf("X'O'\OY\n");  */
/*  printf("X'P'\PY\n");  */
/*  printf("X'Q'\QY\n");  */
/*  printf("X'R'\RY\n");  */
/*  printf("X'S'\SY\n");  */
/*  printf("X'T'\TY\n");  */
/*  printf("X'U'\UY\n"); this is a valid escape sequence */
/*  printf("X'V'\VY\n");  */
/*  printf("X'W'\WY\n");  */
/*  printf("X'X'\XY\n");  */
/*  printf("X'Y'\YY\n");  */
/*  printf("X'Z'\ZY\n");  */
    printf("X'['\[Y\n");
    printf("X'\\'\\Y\n");
/*  printf("X']'\]Y\n");  */
/*  printf("X'^'\^Y\n");  */
/*  printf("X'_'\_Y\n");  */
/*  printf("X'`'\`Y\n");  */
    printf("X'a'\aY\n");
    printf("X'b'\bY\n");
/*  printf("X'c'\cY\n");  */
/*  printf("X'd'\dY\n");  */
    printf("X'f'\fY\n");
/*  printf("X'g'\gY\n");  */
/*  printf("X'h'\hY\n");  */
/*  printf("X'i'\iY\n");  */
/*  printf("X'j'\jY\n");  */
/*  printf("X'k'\kY\n");  */
/*  printf("X'l'\lY\n");  */
/*  printf("X'm'\mY\n");  */
    printf("X'n'\nY\n");
/*  printf("X'o'\oY\n");  */
/*  printf("X'p'\pY\n");  */
/*  printf("X'q'\qY\n");  */
    printf("X'r'\rY\n");
/*  printf("X's'\sY\n");  */
    printf("X't'\tY\n");
/*  printf("X'u'\uY\n"); this is a valid escape sequence */
    printf("X'v'\vY\n");
/*  printf("X'w'\wY\n");  */
/*  printf("X'x'\xY\n"); this is a valid escape sequence */
/*  printf("X'y'\yY\n");  */
/*  printf("X'z'\zY\n");  */
    printf("X'{'\{Y\n");
/*  printf("X'|'\|Y\n");  */
/*  printf("X'}'\}Y\n");  */
/*  printf("X'~'\~Y\n"); */
    printf("X'E'\EY\n");
    printf("X'e'\eY\n");
}

