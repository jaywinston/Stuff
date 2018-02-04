 #CHAPTER 4 Use the Concepts - 1
 #PURPOSE - write a function called square which receives one argument
 #          and returns the square of that argument.
 #
 #INPUT - one number
 #

 #OUTPUT - returns the square of the input
 #

 #VARIABLES - %eax holds the return value
 #

 .section .data

 .section .text
 .type square, @function
square:
 pushl  %ebp                #save old base pointer
 movl   %esp, %ebp          #use stack pointer as base pointer

 movl   12(%ebp), %eax      #move argument into %eax
 imull  %eax, %eax          #multiply %eax by itself and store the return value
                            #in %eax
 ret
