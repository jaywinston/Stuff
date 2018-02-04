 #CHAPTER 6 - Going Further - 1
 #            Rewrite the programs in this chapter to use command-line
 #            arguments to specify the file names.
 #
  .include "linux.s"
  .include "record-def.s"

  .section .bss
  .lcomm record_buffer, RECORD_SIZE


  .section .text
  #Main program
  .globl _start
 _start:
  #This is the location on the stack where
  #we will store the input descriptor
  .equ ST_INPUT_DESCRIPTOR, -4
  #The file name as a command-line argument
  .equ ST_FILE_NAME, 8
  #This will store the largest age
  .equ ST_MAX_AGE, -8

  #Copy the stack pointer to %ebp
  movl  %esp, %ebp
  #Allocate space to hold the file descriptors
  subl  $8, %esp

  #Open the file
  movl  $SYS_OPEN, %eax
  movl  ST_FILE_NAME(%ebp), %ebx
  movl  $0, %ecx    #This says to open read-only
  movl  $660, %edx
  int   $LINUX_SYSCALL

  #Save file descriptor
  movl  %eax, ST_INPUT_DESCRIPTOR(%ebp)

  #initialize MAX_AGE
  movl  $-1, ST_MAX_AGE(%ebp)

 record_read_loop:
  pushl ST_INPUT_DESCRIPTOR(%ebp)
  pushl $record_buffer
  call  read_record
  addl  $8, %esp

  #Returns the number of bytes read.
  #If it isn't the same number we
  #requested, then it's either an
  #end-of-file, or an error, so we're
  #quitting
  cmpl  $RECORD_SIZE, %eax
  jne   finished_reading

  movl  $RECORD_AGE, %edi
  movl  record_buffer(,%edi,1), %eax

  #This completes the initializtion of ST_MAX_AGE
  cmpl  $-1, ST_MAX_AGE(%ebp)
  jne   compare_age
  movl  %eax, ST_MAX_AGE(%ebp)

 compare_age:
  cmpl  ST_MAX_AGE(%ebp), %eax
  jle   continue
  movl  %eax, ST_MAX_AGE(%ebp)

 continue:
  jmp   record_read_loop

 finished_reading:
  movl  ST_MAX_AGE(%ebp), %ebx
  movl  $SYS_EXIT, %eax
  int   $LINUX_SYSCALL

