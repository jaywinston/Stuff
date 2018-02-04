 #CHAPTER 8 - Use the Concepts - 1
 #            Rewrite one or more of the programs from the previous chapters to
 #            print their results to the screen using printf rather than
 #            returning the result as the exit status code.  Also, make the
 #            exit status code be 0.
 #

 #PURPOSE: Write a program to test the square function.
 #

 #INPUT: none
 #

 #OUTPUT: returns the square of the argument as an exit status
 #

 #VARIABLES: message - holds the message to print
 #

 .section .data
message:
 .ascii "%d\n\0"

 .section .text
 .globl _start
_start:
 pushl  $4              # push argument
 call   square          # call the function
 pushl  $message
 call   printf

 movl   $0, %ebx
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

