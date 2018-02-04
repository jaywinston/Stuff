 #CHAPTER 6 - Going Further - 3
 #            Research the various error codes that can be returned by the
 #            system calls made in these programs.  Pick one to rewrite, and
 #            add code that checks %eax for error conditions, and, if one is
 #            found, writes a message about it to STDERR and exit.
 #
 #PURPOSE:  print an error message and exit
 #
 #INPUT:    Error code
 #
 #NOTE:     This is not a function. It exits the program and does not return.
 #

  .include "linux.s"

  .globl exit_on_err
  .type exit_on_err, @function
 exit_on_err:

  .section .data

  .equ ST_ERRNO, 8

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

  pushl %ebp
  movl  %esp, %ebp

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
  subl  ST_ERRNO(%ebp), %edi
  # save errno to return as exit status
  pushl %edi
  movl  ERROR_MESSAGE_TABLE(,%edi,4), %ecx

  ###GET LENGTH OF MESSAGE###
  movl  (%ecx), %edx

  ###GET MESSAGE TEXT###
  addl  $4, %ecx

  ###WRITE TO STDERR###
  movl  $STDERR, %ebx
  movl  $SYS_WRITE, %eax
  int   $LINUX_SYSCALL 

  ###EXIT###
  popl	%ebx  # errno
  movl  $SYS_EXIT, %eax
  int   $LINUX_SYSCALL
