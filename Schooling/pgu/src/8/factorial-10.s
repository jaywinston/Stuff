 #CHAPTER 8 - Use the Concepts - 2
 #            Use the factorial function you developed in the Section called
 #            Recursive Functions in Chapter 4 to make a shared library.
 #            Then rewrite the main program so that it links with the library
 #            dynamically.
 #

 #PURPOSE - Given a number, this program computes the
 #          factorial.  For example, the factorial of
 #          3 is 3 * 2 * 1, or 6.  The factorial of
 #          4 is 4 * 3 * 2 * 1, or 24, and so on.
 #
 
 #This program shows how to call a function recursively.
 
 .section .data
message:
 .ascii "%d\n\0"

 .section .text

 .globl _start
 .globl factorial   #this is unneeded unless we want to share
                    #this function among other programs
_start:
 pushl $4           #The factorial takes one argument - the
                    #number we want a factorial of.  So, it
                    #gets pushed
 call   factorial   #run the factorial function
 addl   $4, %esp    #Scrubs the parameter that was pushed on
                    #the stack
 pushl  %eax
 pushl  $message
 call   printf

 movl   $0, %ebx
 movl   $1, %eax    #call the kernel's exit function
 int $0x80
