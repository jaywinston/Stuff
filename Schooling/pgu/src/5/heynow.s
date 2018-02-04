 #CHAPTER 5 - Use the Concepts - 4
 #  Write a program that will create a file called heynow.txt and write the
 #  words "Hey diddle diddle!" into it.
 #

  ### CONSTANTS ###
  .equ SYS_WRITE, 4
  .equ SYS_OPEN,  5
  .equ SYS_CLOSE, 6
  .equ SYS_EXIT,  1
  .equ O_CREAT_WRONLY_TRUNC, 03101
  .equ LINUX_SYSCALL, 0x80

  .equ ERRNO,  -1
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
  movl  %eax, %ebx  	#return error number as exit status
  jle   exit

  ###SAVE THE FILE DESCRIPTOR###
  movl  %eax, FD

  ###WRITE THE TEXT###
  movl  $SYS_WRITE, %eax
  movl  FD, %ebx
  movl  $TEXT, %ecx
  movl  $TEXT_LENGTH, %edx
  int   $LINUX_SYSCALL

  ###CLOSE THE FILE###
  movl  $SYS_CLOSE, %eax
  movl  FD, %ebx
  int   $LINUX_SYSCALL

  movl  $0, %ebx        #exit status

 exit:
  movl	$SYS_EXIT, %eax
  int   $LINUX_SYSCALL
