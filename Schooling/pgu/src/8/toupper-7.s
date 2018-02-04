 #CHAPTER 8 - Use the Concpets - 4
 #            Rewrite the toupper program so that it uses the c library
 #            functions for files rather than system calls.
 #

 #PURPOSE: This program converts an input file
 #         to an output file with all the letters
 #         converted to uppercase.
 #
 #PROCESSING: 1) Open the input file
 #            2) Open the output file
 #            4) While we're not at the end of the input file
 #               a) read part of file into our memory buffer
 #               b) go through each byte of memory
 #                    if the byte is a lower-case letter,
 #                    convert it to uppercase
 #               c) write the memory buffer to output file
 
  .section .data
 
 READ_ONLY:
  .ascii "r\0"
 WRITE_ONLY:
  .ascii "w\0"

 ######CONSTANTS########
 
  #system call
  .equ SYS_EXIT, 1
 
  #system call interrupt
  .equ LINUX_SYSCALL, 0x80
 
  .equ END_OF_FILE, 0  #This is the return value
                       #of read which means we've
                       #hit the end of the file
 
  .equ NUMBER_ARGUMENTS, 2
 
 .section .bss
  #Buffer - this is where the data is loaded into
  #         from the data file and written from
  #         into the output file. This should
  #         never exceed 16,000 for various
  #         reasons.
  .equ BUFFER_SIZE, 500
  .lcomm BUFFER_DATA, BUFFER_SIZE
 
  .section .text
 
  #STACK POSITIONS
  .equ ST_SIZE_RESERVE, 8
  .equ ST_FILE_IN, -4
  .equ ST_FILE_OUT, -8
  .equ ST_ARGC, 0     #Number of arguments
  .equ ST_ARGV_0, 4   #Name of program
  .equ ST_ARGV_1, 8   #Input file name
  .equ ST_ARGV_2, 12  #Output file name
 
  .globl _start
 _start:
  ###INITIALIZE PROGRAM###
  #save the stack pointer
  movl  %esp, %ebp
 
  #Allocate space for our file descriptors
  #on the stack
  subl  $ST_SIZE_RESERVE, %esp
 
 open_files:
 open_file_in:
  ###OPEN INPUT FILE###
  pushl $READ_ONLY
  pushl ST_ARGV_1(%ebp)
  call  fopen
  addl  $8, %esp

 store_file_in:
  #save the given file pointer
  movl  %eax ,ST_FILE_IN(%ebp)

 open_file_out:
  ###OPEN OUTPUT FILE###
  pushl $WRITE_ONLY
  pushl ST_ARGV_2(%ebp)
  call  fopen
  addl  $8, %esp

 store_file_out:
  #store the file pointer here
  movl  %eax, ST_FILE_OUT(%ebp)

  ###BEGIN MAIN LOOP###
 read_loop_begin:

  ###READ IN A BLOCK FROM THE INPUT FILE###
  pushl	ST_FILE_IN(%ebp)
  pushl	$BUFFER_SIZE
  pushl $BUFFER_DATA
  call  fgets
  addl  $12, %esp

  ###EXIT IF WE'VE REACHED THE END###
  #check for end of file marker
  cmpl  $END_OF_FILE, %eax
  #if found or on error, go to the end
  jle   end_loop

 continue_read_loop:
  ###CONVERT THE BLOCK TO UPPER CASE###
  pushl $BUFFER_DATA    #location of buffer
  call  count_chars
  pushl %eax            #size of the buffer
  call  convert_to_upper
  addl  $8, %esp        #restore %esp

  ###WRITE THE BLOCK OUT TO THE OUTPUT FILE###
  pushl ST_FILE_OUT(%ebp)
  pushl $BUFFER_DATA
  call  fputs
  addl  $8, %esp

  ###CONTINUE THE LOOP###
  jmp   read_loop_begin

 end_loop:
  ###CLOSE THE FILES###
  #NOTE -  we don't need to do error checking
  #        on these, because error conditions
  #        don't signify anything special here
  pushl ST_FILE_OUT(%ebp)
  call  fclose
  addl  $4, %esp

  pushl ST_FILE_IN(%ebp)
  call  fclose
  addl  $4, %esp

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
