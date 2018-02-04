 #CHAPTER 4: Going Further - 4
 #          Come up with your own calling convention.  Rewrite the programs in
 #          this chapter using it.
 #

 #Purpose:  Program to illustrate how functions work
 #           This program will compute the value of
 #           2^0 + 5^2
 #           This is an extension to power-3.s that
 #           returns the correct value when the
 #           power is 0.
 #
 
 # Everything in the main program is stored in registers,
 # so the data section doesn't have anything.
 .section .data
 
 .section .text
 
 .globl _start
_start:
 pushl  $0                  # push second argument
 pushl  $2                  # push first argument
 call   power               # call the function
 addl   $4, %esp            # wipe one argument

 pushl  $2                  # push second argument
 pushl  $5                  # push first argument
 call   power               # call the function
 addl   $4, %esp            # wipe one argument

 popl   %ebx
 popl   %eax

 addl   %eax, %ebx          # add them together
                            # the reult is in %ebx

 movl   $1, %eax            # exit (%ebx is returned)
 int    $0x80

 #PURPOSE:  This function is used to compute
 #          the value of a number raised to
 #          a power.
 #
 #INPUT:    First argument - the base number
 #          Second argument - the power to
 #                            raise it to
 #
 #OUTPUT:   Will give the result as a return value
 #
 #NOTES:    The power must be 1 or greater
 #
 #VARIABLES:
 #          %eax - holds the current result
 #          %ebx - holds the base number
 #          %ecx - holds the power
 #

 .type power, @function
power:
 pushl  %ebp            # save old base pointer
 movl   %esp, %ebp      # make stack pointer the base pointer

 movl   8(%ebp), %ebx   # put first argument in %ebx
 movl   12(%ebp), %ecx  # put second argument in %ecx

 movl   $1, %eax        # if power is 0, then return 1
 cmpl   $0, %ecx
 je     end_power

power_loop_start:
 imull  %ebx, %eax      # multiply the current result by
                        # the base number
 cmpl   $1, %ecx        # if the power is 1, we are done
 je     end_power

 decl   %ecx            # decrease the power
 jmp    power_loop_start    # run for the next power

end_power:
 movl   %eax, 12(%ebp)  # return value in 12(%ebp)
 movl   %ebp, %esp      # restore the stack pointer
 popl   %ebp            # restore the base pointer
 ret

