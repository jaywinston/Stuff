 #CHAPTER 8 - Use the Concepts - 1
 #            Rewrite one or more of the programs from the previous chapters to
 #            print their results to the screen using printf rather than
 #            returning the result as the exit status code.  Also, make the
 #            exit status code be 0.
 #

 #PURPOSE:  This program finds the maximum number of a
 #          set of data items.
 #

 #VARIABLES:    The registers have the following uses:
 #
 # %edi - Holds the index of the data item being examined
 # %ebx - Largest data item found
 # %eax - Current data item
 #
 # The following memory locations are used:
 #
 # data_items - contains the item data.  255 is used
 #              to terminate the data
 #
 # fstring - holds the formatting string
 #

 .section .data

data_items:     #These are the data items
 .long 3,67,34,222,45,75,54,34,44,33,22,11,66,255

fstring:
 .ascii "%d\n\0"
 .section .text

 .globl _start
_start:
 movl $0, %edi              # move 255 into the index register
 movl data_items(,%edi,4),  %eax # load the first byte of data
 movl %eax, %ebx            # since this is the first item, %eax is
                            # the biggest

start_loop:                 # start loop
 incl %edi                  # load next value
 movl data_items(,%edi,4),  %eax
 cmpl $255, %eax            # check to see if we've hit the end
 je loop_exit
 cmpl %ebx, %eax            # compare values
 jle start_loop             # jump to loop beginning if the new
                            # one isn't bigger
 movl %eax, %ebx            # move the value as the largest
 jmp start_loop             # jump to loop beginning

loop_exit:
        pushl %ebx
        pushl $fstring
        call printf
        movl $0, %ebx
        movl $1, %eax           #1 is the exit() syscall
        int $0x80
 
