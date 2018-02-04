 #CHAPTER 6 - Going Further - 3
 #            Research the various error codes that can be returned by the
 #            system calls made in these programs.  Pick one to rewrite, and
 #            add code that checks %eax for error conditions, and, if one is
 #            found, writes a message about it to STDERR and exit.
 #

  .include "linux.s"
  .include "record-def.s"

  .section .data
 file_name:
  .ascii "test.dat\0"

  .section .bss
  .lcomm record_buffer, RECORD_SIZE

  #Stack offsets of local variables
  .equ ST_FILE_DESCRIPTOR, -4

  .section .text
  .globl _start
 _start:
  #Copy stack pointer and make room for local variable
  movl  %esp, %ebp
  subl  $4, %esp

  #Open file for read/write
  movl  $SYS_OPEN, %eax
  movl  $file_name, %ebx
  movl  $2, %ecx
  movl  $0660, %edx
  int   $LINUX_SYSCALL

  cmpl  $0, %eax
  jge   opened_ok
  push  %eax
  call  exit_on_err
  #the function will exit the program

 opened_ok:
  movl  %eax, ST_FILE_DESCRIPTOR(%ebp)

 loop_begin:
  pushl ST_FILE_DESCRIPTOR(%ebp)
  pushl $record_buffer
  call  read_record
  addl  $8, %esp

  cmpl  $0, %eax
  jge   read_ok
  push  %eax
  call  exit_on_err
  #the function will exit the program

 read_ok:

  #Returns the number of bytes read.
  #If it isn't the same number we
  #requested, then it's either an
  #end-of-file, or an error, so we're
  #quitting
  cmpl  $RECORD_SIZE, %eax
  jne   loop_end

  #Increment the age
  incl  record_buffer + RECORD_AGE

  movl $19, %eax
  movl ST_FILE_DESCRIPTOR(%ebp), %ebx
  movl $-RECORD_SIZE, %ecx
  movl $1, %edx
  int $0x80

  cmpl  $0, %eax
  jge   sought_ok
  push  %eax
  call  exit_on_err
  #the function will exit the program

 sought_ok:

  #Write the record out
  pushl ST_FILE_DESCRIPTOR(%ebp)
  pushl $record_buffer
  call  write_record
  addl  $8, %esp

  cmpl  $0, %eax
  jge   wrote_ok
  push  %eax
  call  exit_on_err
  #the function will exit the program

 wrote_ok:

  jmp   loop_begin

 loop_end:
  movl  $SYS_CLOSE, %eax
  movl  ST_FILE_DESCRIPTOR(%ebp), %ebx
  int   $LINUX_SYSCALL

  cmpl  $0, %eax
  jge   closed_ok
  push  %eax
  call  exit_on_err
  #the function will exit the program

 closed_ok:
  movl  $SYS_EXIT, %eax
  movl  $0, %ebx
  int   $LINUX_SYSCALL
