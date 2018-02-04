 #CHAPTER 4 - Going Further - 4: square-3.s
 #

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
 pushl  $4              # push argument
 call   square          # call the function
 popl   %ebx            # move the return value to %ebx

 movl   $1, %eax        # move exit code to %eax
 int    $0x80           # interrupt


 #PURPOSE: return the square of a number
 #

 #INPUT: one number
 #

 #OUTPUT: returns the square of the input
 #

 #VARIABLES:    8(%ebp) - Holds the argument
 #              %edx - Holds the return address
 #

 .section .data

 .section .text
 .type square, @function
square:
 pushl  %ebp                # save old base pointer
 movl   %esp, %ebp          # use stack pointer as base pointer

 movl   8(%ebp), %eax       # multiply %eax by itself and store
 imull  %eax, %eax          # the return value in 8(%ebp)
 movl   %eax, 8(%ebp)

 movl   %ebp, %esp          # restore %esp and %ebp
 popl   %ebp
 ret

