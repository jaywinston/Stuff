 #CHAPTER 8 - Use the Concepts - 2
 #            Use the factorial function you developed in the Section called
 #            Recursive Functions in Chapter 4 to make a shared library.
 #            Then rewrite the main program so that it links with the library
 #            dynamically.
 #

 #PURPOSE - Given a number, this function computes the
 #          factorial.  For example, the factorial of
 #          3 is 3 * 2 * 1, or 6.  The factorial of
 #          4 is 4 * 3 * 2 * 1, or 24, and so on.
 #
 
 .globl factorial
 .type factorial,@function
factorial:
 pushl  %ebp        #standard function stuff - we have to
                    #restore %ebp to its prior state before
                    #returning, so we have to push it
 movl   %esp, %ebp  #This is because we don't want to modify
                    #the stack pointer, so we use %ebp.

 movl   8(%ebp), %eax   #This moves the first argument to %eax
                    #4(%ebp) holds the return address, and
                    #8(%ebp) holds the first parameter
 cmpl   $1, %eax        #If the number is 1, that is our base
                        #case, and we simply return (1 is
                        #already in %eax as the return value)

 je end_factorial
 decl   %eax            #otherwise, decrease the value
 pushl  %eax            #push it for our call to factorial
 call   factorial       #call factorial
 movl   8(%ebp), %ebx   #%eax has the return value, so we
                        #reload our parameter into %ebx
 imull  %ebx, %eax      #miltiply that by  the result of the
                        #last call to factorial (in %eax)
                        #the answer is stored in %eax, which
                        #is good since that's where return
                        #values go.

end_factorial:
 movl   %ebp, %esp      #standard function return stuff - we
 popl   %ebp            #have to restore %ebp and %esp to where
                        #they were before the function started
 ret                    #return to the function (this pops the
                        #return value, too)
