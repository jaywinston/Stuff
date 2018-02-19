 #CHAPTER 8 - Use the Concepts - 1
 #            Rewrite one or more of the programs from the previous chapters to
 #            print their results to the screen using printf rather than
 #            returning the result as the exit status code.  Also, make the
 #            exit status code be 0.
 #

 # Modify the maximum program to use an ending address rather than the number
 # 0 to know when to stop.
 #
 # This doesn't seem to me the best solution.  But I can't think of any other.
 #

 #PURPOSE:  This program finds the maximum number of a
 #          set of data items.
 #

 #VARIABLES:    The registers have the following uses:
 #
 # %edi - Holds the index of the data item being examined
 # %edx - Holds the starting address
 # %ecx - Holds the ending address
 # %ebx - Largest data item found
 # %eax - Current data item
 #
 # The following memory locations are used:
 #
 # data_items - contains the item data.
 # message - contains the message to print
 #

 .section .data

data_items:     #These are the data items
 .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
message:
 .ascii "%d\n\0"

 .section .text

 .globl _start
_start:
 movl $0, %edi              # move 0 into the index register
 movl data_items(,%edi,4),  %eax # load the first byte of data
 movl %eax, %ebx            # since this is the first item, %eax is
                            # the biggest
 movl $data_items, %edx     # move the starting address into %edx
 movl $56, %ecx             # move the ending address into %ecx
 addl $data_items, %ecx

start_loop:                 # start loop
 addl $4, %edx              # increment address counter by 4
 cmpl %ecx, %edx            # check to see if we've hit the end
 je loop_exit
 incl %edi                  # load next value
 movl data_items(,%edi,4),  %eax
 cmpl %ebx, %eax            # compare values
 jle start_loop             # jump to loop beginning if the new
                            # one isn't bigger
 movl %eax, %ebx            # move the value as the largest
 jmp start_loop             # jump to loop beginning

loop_exit:
        pushl %ebx
        pushl $message
        call printf
        movl $1, %eax           #1 is the exit() syscall
        int $0x80
 
