 #CHAPTER 5 - Going Further - 4
 #      Modify the program so that it checks the results of each system call,
 #      and prints out an error message to STDOUT when it occurs.
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
 
 ######CONSTANTS########
 
  #system call numbers
  .equ SYS_OPEN, 5
  .equ SYS_WRITE, 4
  .equ SYS_READ, 3
  .equ SYS_CLOSE, 6
  .equ SYS_EXIT, 1
 
  #options for open (look at
  #/usr/include/asm/fcntl.h for
  #various values.  You can combine them
  #by adding them or ORing them)
  #This is discussed at greater length
  #in "Counting Like a Computer"
  .equ O_RDONLY, 0
  .equ O_CREAT_WRONLY_TRUNC, 03101
 
  #standard file descriptors
  .equ STDIN, 0
  .equ STDOUT, 1
  .equ STDERR, 2
 
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
  .equ ST_FD_IN, -4
  .equ ST_FD_OUT, -8
  .equ ST_ARGC, 0      #Number of arguments
  .equ ST_ARGV_0, 4   #Name of program
  .equ ST_ARGV_1, 8   #Input file name
  .equ ST_ARGV_2, 12   #Output file name
 
  .globl _start
 _start:
  ###INITIALIZE PROGRAM###
  #save the stack pointer
  movl  %esp, %ebp
 
  #Allocate space for our file descriptors
  #on the stack
  subl  $ST_SIZE_RESERVE, %esp
 
 open_files:
 open_fd_in:
  ###OPEN INPUT FILE###
  #open syscall
  movl  $SYS_OPEN, %eax
  #input filename into %ebx
  movl  ST_ARGV_1(%ebp), %ebx
  #read-only flag
  movl  $O_RDONLY, %ecx
  #this doesn't really matter for reading
  movl  $0666, %edx
  #call Linux
  int   $LINUX_SYSCALL
  #check for error
  cmpl  $0, %eax
  jl    exit_on_err

 store_fd_in:
  #save the given file descriptor
  movl  %eax ,ST_FD_IN(%ebp)

 open_fd_out:
  ###OPEN OUTPUT FILE###
  #open the file
  movl  $SYS_OPEN, %eax
  #ouput filname into %ebx
  movl  ST_ARGV_2(%ebp), %ebx
  #flags for writing to the file
  movl  $O_CREAT_WRONLY_TRUNC, %ecx
  #mode for new file (if it's created)
  movl  $0666, %edx
  #call Linux
  int   $LINUX_SYSCALL
  #check for error
  cmpl  $0, %eax
  jl    exit_on_err

 store_fd_out:
  #store the file descritor here
  movl  %eax, ST_FD_OUT(%ebp)

  ###BEGIN MAIN LOOP###
 read_loop_begin:

  ###READ IN A BLOCK FROM THE INPUT FILE###
  movl  $SYS_READ, %eax
  #get the input file descriptor
  movl	ST_FD_IN(%ebp), %ebx
  #the location to read into
  movl  $BUFFER_DATA, %ecx
  #the size of the buffer
  movl	$BUFFER_SIZE, %edx
  #Size of buffer read is returned in %eax
  int   $LINUX_SYSCALL
  #check for error
  cmpl  $0, %eax
  jl    exit_on_err

  ###EXIT IF WE'VE REACHED THE END###
  #check for end of file marker
  cmpl  $END_OF_FILE, %eax
  #if found or on error, go to the end
  jle   end_loop

 continue_read_loop:
  ###CONVERT THE BLOCK TO UPPER CASE###
  pushl $BUFFER_DATA    #location of buffer
  pushl %eax            #size of the buffer
  call  convert_to_upper
  popl  %eax            #get the size back
  addl  $4, %esp        #restore %esp

  ###WRITE THE BLOCK OUT TO THE OUTPUT FILE###
  #size of the buffer
  movl  %eax, %edx
  movl  $SYS_WRITE, %eax
  #file to use
  movl  ST_FD_OUT(%ebp), %ebx
  #location of the buffer
  movl  $BUFFER_DATA, %ecx
  int   $LINUX_SYSCALL
  #check for error
  cmpl  $0, %eax
  jl    exit_on_err

  ###CONTINUE THE LOOP###
  jmp   read_loop_begin

 end_loop:
  ###CLOSE THE FILES###
  #NOTE -  we don't need to do error checking
  #        on these, because error conditions
  #        don't signify anything special here
  # I don't know if this note is referring to this exercise.
  movl  $SYS_CLOSE, %eax
  movl  ST_FD_OUT(%ebp), %ebx
  int   $LINUX_SYSCALL
  #check for error
  cmpl  $0, %eax
  jl    exit_on_err

  movl  $SYS_CLOSE, %eax
  movl  ST_FD_IN(%ebp), %ebx
  int   $LINUX_SYSCALL
  #check for error
  cmpl  $0, %eax
  jl    exit_on_err

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


 #PURPOSE:  print an error message and exit
 #
 #INPUT:    Error code
 #
 #NOTE:     This is not a function. It exits the program and does not return.
 #

 exit_on_err:

  .section .data

  ###BEGIN BUILD MESSAGE TABLE###
  #error numbers
  .equ EPERM,           1   # Operation not permitted
  .equ ENOENT,          2   # No such file or directory
  .equ EINTR,           4   # Interrupted system call
  .equ EIO,             5   # I/O error
  .equ ENXIO,           6   # No such device or address
  .equ EBADF,           9   # Bad file number
  .equ EAGAIN,          11  # Try again
  .equ EWOULDBLOCK,     EAGAIN  # Operation would block
  .equ ENOMEM,          12  # Out of memory
  .equ EACCES,          13  # Permission denied
  .equ EFAULT,          14  # Bad address
  .equ EEXIST,          17  # File exists
  .equ ENODEV,          19  # No such device
  .equ ENOTDIR,         20  # Not a directory
  .equ EISDIR,          21  # Is a directory
  .equ EINVAL,          22  # Invalid argument
  .equ ENFILE,          23  # File table overflow
  .equ EMFILE,          24  # Too many open files
  .equ ETXTBSY,         26  # Text file busy
  .equ EFBIG,           27  # File too large
  .equ ENOSPC,          28  # No space left on device
  .equ EROFS,           30  # Read-only file system
  .equ EPIPE,           32  # Broken pipe
  .equ ENAMETOOLONG,    36  # File name too long
  .equ ELOOP,           40  # Too many symbolic links encountered
  .equ EOVERFLOW,       75  # Value too large for defined data type
  .equ EBADFD,          77  # File descriptor in bad state
  .equ EDESTADDRREQ,    89  # Destination address required
  .equ EOPNOTSUPP,      95  # Operation not supported on transport endpoint
  .equ EREMOTEIO,       121 # Remote I/O error
  .equ EDQUOT,          122 # Quota exceeded

  #error messages
 EPERM_MSG:
  .long 24
  .ascii "Operation not permitted\n"
 ENOENT_MSG:
  .long 26
  .ascii "No such file or directory\n"
 EINTR_MSG:
  .long 24
  .ascii "Interrupted system call\n"
 EIO_MSG:
  .long 10
  .ascii "I/O error\n"
 ENXIO_MSG:
  .long 26
  .ascii "No such device or address\n"
 EBADF_MSG:
  .long 16
  .ascii "Bad file number\n"
 EAGAIN_MSG:
  .long 10
  .ascii "Try again\n"
 EWOULDBLOCK_MSG:
  .long 22
  .ascii "Operation would block\n"
 ENOMEM_MSG:
  .long 14
  .ascii "Out of memory\n"
 EACCES_MSG:
  .long 18
  .ascii "Permission denied\n"
 EFAULT_MSG:
  .long 12
  .ascii "Bad address\n"
 EEXIST_MSG:
  .long 12
  .ascii "File exists\n"
 ENODEV_MSG:
  .long 15
  .ascii "No such device\n"
 ENOTDIR_MSG:
  .long 16
  .ascii "Not a directory\n"
 EISDIR_MSG:
  .long 15
  .ascii "Is a directory\n"
 EINVAL_MSG:
  .long 17
  .ascii "Invalid argument\n"
 ENFILE_MSG:
  .long 20
  .ascii "File table overflow\n"
 EMFILE_MSG:
  .long 20
  .ascii "Too many open files\n"
 ETXTBSY_MSG:
  .long 15
  .ascii "Text file busy\n"
 EFBIG_MSG:
  .long 15
  .ascii "File too large\n"
 ENOSPC_MSG:
  .long 24
  .ascii "No space left on device\n"
 EROFS_MSG:
  .long 22
  .ascii "Read-only file system\n"
 EPIPE_MSG:
  .long 12
  .ascii "Broken pipe\n"
 ENAMETOOLONG_MSG:
  .long 19
  .ascii "File name too long\n"
 ELOOP_MSG:
  .long 36
  .ascii "Too many symbolic links encountered\n"
 EOVERFLOW_MSG:
  .long 38
  .ascii "Value too large for defined data type\n"
 EBADFD_MSG:
  .long 29
  .ascii "File descriptor in bad state\n"
 EDESTADDRREQ_MSG:
  .long 29
  .ascii "Destination address required\n"
 EOPNOTSUPP_MSG:
  .long 46
  .ascii "Operation not supported on transport endpoint\n"
 EREMOTEIO_MSG:
  .long 17
  .ascii "Remote I/O error\n"
 EDQUOT_MSG:
  .long 15
  .ascii "Quota exceeded\n"

  .section .bss

  .lcomm ERROR_MESSAGE_TABLE, 488  # 122 max error value * 4 bytes per entry

  .section .text

  ###POPULATE ERROR TABLE###
  movl	$EPERM, %edi
  movl	$EPERM_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENOENT, %edi
  movl	$ENOENT_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EINTR, %edi
  movl	$EINTR_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EIO, %edi
  movl	$EIO_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENXIO, %edi
  movl	$ENXIO_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EBADF, %edi
  movl	$EBADF_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EAGAIN, %edi
  movl	$EAGAIN_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EWOULDBLOCK, %edi
  movl	$EWOULDBLOCK_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENOMEM, %edi
  movl	$ENOMEM_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EACCES, %edi
  movl	$EACCES_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EFAULT, %edi
  movl	$EFAULT_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EEXIST, %edi
  movl	$EEXIST_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENODEV, %edi
  movl	$ENODEV_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENOTDIR, %edi
  movl	$ENOTDIR_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EISDIR, %edi
  movl	$EISDIR_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EINVAL, %edi
  movl	$EINVAL_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENFILE, %edi
  movl	$ENFILE_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EMFILE, %edi
  movl	$EMFILE_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ETXTBSY, %edi
  movl	$ETXTBSY_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EFBIG, %edi
  movl	$EFBIG_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENOSPC, %edi
  movl	$ENOSPC_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EROFS, %edi
  movl	$EROFS_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EPIPE, %edi
  movl	$EPIPE_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ENAMETOOLONG, %edi
  movl	$ENAMETOOLONG_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$ELOOP, %edi
  movl	$ELOOP_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EOVERFLOW, %edi
  movl	$EOVERFLOW_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EBADFD, %edi
  movl	$EBADFD_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EDESTADDRREQ, %edi
  movl	$EDESTADDRREQ_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EOPNOTSUPP, %edi
  movl	$EOPNOTSUPP_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EREMOTEIO, %edi
  movl	$EREMOTEIO_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  movl	$EDQUOT, %edi
  movl	$EDQUOT_MSG, ERROR_MESSAGE_TABLE(,%edi,4)
  ###END BUILD MESSAGE TABLE###

  ###PRINT THE MESSAGE###
  #This is dangerous because the message table is incomplete.
  #todo: finish message table

  ###GET THE MESSAGE###

  ###GET THE RECORD###
  # status code is negative but errno should be positive
  movl  $0, %edi
  subl  %eax, %edi
  # save errno to return as exit status
  pushl %edi
  movl  ERROR_MESSAGE_TABLE(,%edi,4), %ecx

  ###GET LENGTH OF MESSAGE###
  movl  (%ecx), %edx

  ###GET MESSAGE TEXT###
  addl  $4, %ecx

  ###WRITE TO STDOUT###
  movl  $STDOUT, %ebx
  movl  $SYS_WRITE, %eax
  int   $LINUX_SYSCALL 

  ###EXIT###
  popl	%ebx  # errno
  movl  $SYS_EXIT, %eax
  int   $LINUX_SYSCALL
