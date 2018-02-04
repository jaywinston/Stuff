 #CHAPTER 7 - Use the Concepts - 2
 # Find one other program we have done so far, and add error-checking to that
 # program.
 #

  ### CONSTANTS ###
  .equ SYS_WRITE, 4
  .equ SYS_OPEN,  5
  .equ SYS_CLOSE, 6
  .equ SYS_EXIT,  1
  .equ O_CREAT_WRONLY_TRUNC, 03101
  .equ LINUX_SYSCALL, 0x80

  .equ ERRNO, 0
  .equ TEXT_LENGTH, 19


  .section .bss

  ###FILE DESCRIPTOR###
  .lcomm FD, 4


  .section .data

 FILENAME:
  .ascii "heynow.txt\0"
 TEXT:
  .ascii "Hey diddle diddle!\n"


  .section .text

  .globl _start
 _start:
  
  ###OPEN FILE###
  movl  $SYS_OPEN, %eax
  movl  $FILENAME, %ebx
  movl  $O_CREAT_WRONLY_TRUNC, %ecx
  movl  $0660, %edx
  int   $LINUX_SYSCALL

  ###TEST THE FILE DESCRIPTOR###
  cmpl  $ERRNO, %eax
  jl    err_

  ###SAVE THE FILE DESCRIPTOR###
  movl  %eax, FD

  ###WRITE THE TEXT###
  movl  $SYS_WRITE, %eax
  movl  FD, %ebx
  movl  $TEXT, %ecx
  movl  $TEXT_LENGTH, %edx
  int   $LINUX_SYSCALL

  ###TEST THE RETURN STATUS###
  cmpl  $ERRNO, %eax
  jl    err_

  ###CLOSE THE FILE###
  movl  $SYS_CLOSE, %eax
  movl  FD, %ebx
  int   $LINUX_SYSCALL

  ###TEST THE RETURN STATUS###
  cmpl  $ERRNO, %eax
  jl    err_

  movl  $0, %ebx        #exit status

 exit:
  movl	$SYS_EXIT, %eax
  int   $LINUX_SYSCALL

 err_:
  pushl %eax
  call exit_on_err
