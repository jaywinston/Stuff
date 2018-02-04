 #CHAPTER 5 - Use the Concepts - 1
 #  Modify the toupper program so that it reads from STDIN and writes to
 #  STDOUT instead of using the files on the command-line.
 #
 #PURPOSE: This program converts input from STDIN
 #         to output on STDOUT with all the letters
 #         converted to uppercase.
 #
 #PROCESSING:   While we're not at the end of input
 #               a) read part of input into our memory buffer
 #               b) go through each byte of memory
 #                    if the byte is a lower-case letter,
 #                    convert it to uppercase
 #               c) write the memory buffer to STDOUT
 
  .section .data
 
 ######CONSTANTS########
 
  #system call numbers
  .equ SYS_WRITE, 4
  .equ SYS_READ, 3
  .equ SYS_EXIT, 1
 
  #standard file descriptors
  .equ STDIN, 0
  .equ STDOUT, 1
  .equ STDERR, 2
 
  #system call interrupt
  .equ LINUX_SYSCALL, 0x80
 
  .equ END_OF_INPUT, 0  #This is the return value
                        #of read which means we've
                        #hit the end of the input
 
 
 .section .bss
  #Buffer - this is where the data is loaded into
  #         from STDIN and written from
  #         onto STDOUT. This should
  #         never exceed 16,000 for various
  #         reasons.
  .equ BUFFER_SIZE, 500
  .lcomm BUFFER_DATA, BUFFER_SIZE
 
  .section .text
 
  .globl _start
 _start:
  ###INITIALIZE PROGRAM###
  #save the stack pointer
  movl  %esp, %ebp
 
  ###BEGIN MAIN LOOP###
 read_loop_begin:

  ###READ IN A BLOCK FROM STDIN###
  movl  $SYS_READ, %eax
  #read from STDIN
  movl	$STDIN, %ebx
  #the location to read into
  movl  $BUFFER_DATA, %ecx
  #the size of the buffer
  movl	$BUFFER_SIZE, %edx
  #Size of buffer read is returned in %eax
  int   $LINUX_SYSCALL

  ###EXIT IF WE'VE REACHED THE END###
  #check for end of input marker
  cmpl  $END_OF_INPUT, %eax
  #if found or on error, go to the end
  jle   end_loop

 continue_read_loop:
  ###CONVERT THE BLOCK TO UPPER CASE###
  pushl $BUFFER_DATA    #location of buffer
  pushl %eax            #size of the buffer
  call  convert_to_upper
  popl  %eax            #get the size back
  addl  $4, %esp        #restore %esp

  ###WRITE THE BLOCK OUT TO STDOUT###
  #size of the buffer
  movl  %eax, %edx
  movl  $SYS_WRITE, %eax
  #STDOUT
  movl  $STDOUT, %ebx
  #location of the buffer
  movl  $BUFFER_DATA, %ecx
  int   $LINUX_SYSCALL

  ###CONTINUE THE LOOP###
  jmp   read_loop_begin

 end_loop:

  ###EXIT###
  movl  $SYS_EXIT, %eax
  movl  $0, %ebx
  int   $LINUX_SYSCALL


 #PURPOSE:  This function actually does the
 #          conversion to upper case for a block
 #
 #INPUT:    The first parameter is the location
 #          of the block of memory to convert
 #          The second parameter is the length of
 #           that buffer
 #
 #OUTPUT:   This function overwrites the current
 #          buffer with the upper-casified version.
 #
 #VARIABLES:
 #          %eax - beginning of buffer
 #          %ebx - length of buffer
 #          %edi - current buffer offset
 #          %cl - current byte being examined
 #                  (first part of %ecx)
 #

  ###CONSTANTS##
  #The lower boundary of our search
  .equ	LOWERCASE_A, 'a'
  #The upper boundary of our search
  .equ  LOWERCASE_Z, 'z'
  #Conversion between upper and lower case
  .equ  UPPER_CONVERSION, 'A' - 'a'

  ###STACK STUFF###
  .equ  ST_BUFFER_LEN, 8 #Length of buffer
  .equ  ST_BUFFER, 12    #actual buffer
 convert_to_upper:
  pushl %ebp
  movl  %esp, %ebp

  ###SET UP VARIABLES###
  movl  ST_BUFFER(%ebp), %eax
  movl  ST_BUFFER_LEN(%ebp), %ebx
  movl  $0, %edi
  #if a buffer with zero length was given
  #to us, just leave
  cmpl  $0, %ebx
  je    end_convert_loop

 convert_loop:
  #get the current byte
  movb  (%eax,%edi,1), %cl

  #go to the next byte unless it is between
  #'a' and 'z'
  cmpb  $LOWERCASE_A, %cl
  jl    next_byte
  cmpb  $LOWERCASE_Z, %cl
  jg    next_byte

  #otherwise convert the byte to uppercase
  addb  $UPPER_CONVERSION, %cl
  #and store it back
  movb  %cl, (%eax,%edi,1)
 next_byte:
  incl  %edi                #next byte
  cmpl  %edi, %ebx          #continue unless
                            #we've reached the
                            #end
  jne   convert_loop

 end_convert_loop:
  #no return value, just leave
  movl  %ebp, %esp
  popl  %ebp
  ret
