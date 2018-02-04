 #CHAPTER 4 - Going Further - 2
 #          Make the factorial function non-recursive.
 #

 #PURPOSE - Given a number, this program computes the
 #          factorial.  For example, the factorial of
 #          3 is 3 * 2 * 1, or 6.  The factorial of
 #          4 is 4 * 3 * 2 * 1, or 24, and so on.
 #
 
 .section .data

 # This program has no global data

 .section .text

 .globl _start
 .globl factorial   # this is unneeded unless we want to share
                    # this function among other programs
_start:
 pushl $4           # The factorial takes one argument - the
                    # number we want a factorial of.  So, it
                    # gets pushed
 call   factorial   # run the factorial function

 popl   %ebx        # move the return value to %ebx

 movl   $1, %eax    # call the kernel's exit function
 int $0x80


 # This is the actual function definition
 .type factorial,@function
factorial:
 pushl  %ebp        # standard function stuff - we have to
                    # restore %ebp to its prior state before
                    # returning, so we have to push it
 movl   %esp, %ebp  # This is because we don't want to modify
                    # the stack pointer, so we use %ebp.

 movl   8(%ebp), %ebx   # This moves the first argument to %ebx
 movl   8(%ebp), %eax   # This moves the first argument to %eax
                        # 4(%ebp) holds the return address, and
                        # 8(%ebp) holds the first parameter.

loop:
 cmpl   $1, %ebx        # If %ebx is 1 then return.
 je     end_factorial

 decl   %ebx            # decrement %ebx
 imull  %ebx, %eax      # Multiply that by the result of the
                        # last iteration.
 jmp    loop            # jump to start of loop

end_factorial:
 movl   %eax, 8(%ebp)   # put the return value on the stack
 movl   %ebp, %esp      # standard function return stuff - we
 popl   %ebp            # have to restore %ebp and %esp to where
                        # they were before the function started
 ret                    # return to the function (this pops the
                        # return value, too)
