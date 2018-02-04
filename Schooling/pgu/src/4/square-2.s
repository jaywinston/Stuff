 #CHAPTER - 4 Use the Concepts - 2
 #PURPOSE: Write a program to test the square function.
 #

 #INPUT: none
 #

 #OUTPUT: returns the square of the argument as an exit status
 #

 #VARIABLES: none
 #

 .section .data

 .section .text
 .globl _start
_start:
 pushl  $4              #push argument
 call   square          #call the function
 addl   $4, %esp        #discard parameter
 movl   %eax, %ebx      #move the return value to %ebx

 movl   $1, %eax        #move exit code to %eax
 int    $0x80           #interrupt


 #PURPOSE: return the square of a number
 #

 #INPUT: one number
 #

 #OUTPUT: returns the square of the input
 #

 #VARIABLES:    %eax -  Holds the return value
 #      8(%ebp) - Holds the argument
 #

 .section .data

 .section .text
 .type square, @function
square:
 pushl  %ebp                #save old base pointer
 movl   %esp, %ebp          #use stack pointer as base pointer

 movl   8(%ebp), %eax       #move argument into %eax
 imull  %eax, %eax          #multiply %eax by itself and store the return value
                            #in %eax
 movl   %ebp, %esp          #restore %esp and %ebp
 popl   %ebp
 ret

