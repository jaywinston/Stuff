 #CHAPTER 4 - Use the Concepts - 3
 #

 #PURPOSE:  Convert the maximum program given in the Section call
 #          "Finding a maxumum Value" in Chapter 3 so that it is a
 #          function which takes a pointer to several values and
 #          returns their maximum.  Write a program that calls maximum
 #          with 3 different lists and returns the result of the last
 #          one as the program's exit status.
 #

 #VARIABLES:    list1, list2, list3 - Hold several values each
 #

 .section .data
list1:
 .long 34,5,63,67,212,67,87,123,0
list2:
 .long 90,23,85,0
list3:
 .long 45,23,97,45,74,234,0

 .section .text
 .globl _start
_start:

 pushl  $list1      # push argument
 call   maximum

 pushl  $list2      # push argument
 call   maximum

 pushl  $list3      # push argument
 call   maximum

 popl   %ebx        # move return value to %ebx
 movl   $1, %eax
 int    $0x80


 #PURPOSE:  Find the maximum number of set of data items.
 #

 #VARIABLES:    %ebx - Holds the pointer to the data items
 #              %eax - Holds the largest value
 #              %edi - Holds the index
 #

 #NOTES:    This function takes a pointer as its argument.
 #

 .type maximum, @function
maximum:
 pushl  %ebp                    # save %ebp
 movl   %esp, %ebp              # save %esp in %ebp

 movl   8(%ebp), %ebx           # move pointer into %ebx

 movl   $0, %edi                # move 0 into the index register
 movl   (%ebx,%edi,4), %eax     # load the first byte of data
                                # the biggest

start_loop:                     # start loop
 cmpl   $0, (%ebx,%edi,4)       # check to see if we've hit the end
 je     loop_exit
 incl   %edi                    # load next value
 cmpl   %eax, (%ebx,%edi,4)     # compare values
 jle    start_loop              # jump to loop beginning if the new
                                # one isn't bigger
 movl   (%ebx,%edi,4), %eax     # move the value as the largest
 jmp    start_loop              # jump to loop beginning

loop_exit:
 movl   %eax, 8(%ebp)           # put return value on the stack
 movl   %ebp, %esp              # restore %esp and %ebp
 popl   %ebp
 
 ret

