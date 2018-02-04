 #CHAPTER 8 - Use the Concepts - 1
 #            Rewrite one or more of the programs from the previous chapters to
 #            print their results to the screen using printf rather than
 #            returning the result as the exit status code.  Also, make the
 #            exit status code be 0.
 #

 #Purpose:  Program to illustrate how functions work
 #           This is the mid-chapter project to extend
 #           the program so it will retrn the value of
 #           number if the power is 0.
 #           This program will compute the value of
 #           2^0 + 5^2
 #
 
 .section .data
message:
 .ascii "%d\n\0"
 
 .section .text
 
 .globl _start
_start:
 pushl  $0                  #push second argument
 pushl  $2                  #push first argument
 call   power               #call the function
 addl   $8, %esp            #move the stack pointer back
 pushl  %eax                #save the first answer before
                            #calling the next fuction

 pushl  $2                  #push second argument
 pushl  $5                  #push first argument
 call   power               #call the function
 addl   $8, %esp            #move the stack pointer back

 popl   %ebx                #The second answer is already
                            #in %eax.  We saved the
                            #first answer onto the stack,
                            #so now we can just pop it
                            #out into %ebx

 addl   %eax, %ebx          #add them together
                            #the result is in %ebx
 pushl  %ebx
 pushl  $message
 call   printf

 movl   $0, %ebx
 movl   $1, %eax
 int    $0x80

 #PURPOSE:  This function is used to compute
 #          the value of a number raised to
 #          a power.
 #
 #INPUT:    First argument - the base number
 #          Secong argument - the power to
 #                            raise it to
 #
 #OUTPUT:   Will give the result as a return value
 #
 #NOTES:    The power must be 1 or greater
 #
 #VARIABLES:
 #          %ebx - holds the base number
 #          %ecx - holds the power
 #
 #          -4(%ebp) - holds the current result
 #
 #          %eax is used for temporary storage
 .type power, @function
power:
 pushl  %ebp            #save old base pointer
 movl   %esp, %ebp      #make stack pointer the base pointer
 subl   $4, %esp        #get room for out local storage

 movl   $1, -4(%ebp)   #if power is 0 then return 1
 cmpl   $0, 12(%ebp)
 je     end_power

 movl   8(%ebp), %ebx   #put first argument in %eax
 movl   12(%ebp), %ecx  #put second argument in %ecx

 movl   %ebx, -4(%ebp)  #store current result

power_loop_start:
 cmpl   $1, %ecx        #if the power is 1, we are done
 je     end_power
 movl   -4(%ebp), %eax  #move the current result into %eax
 imull  %ebx, %eax      #multiply the current result by
                        #the base number
 movl   %eax, -4(%ebp)  #store the current result

 decl   %ecx            # decrease the power
 jmp    power_loop_start    #run for the next power

end_power:
 movl -4(%ebp), %eax    #return value goes in %eax
 movl %ebp, %esp        #restore the stack pointer
 popl %ebp              #restore the base pointer
 ret

