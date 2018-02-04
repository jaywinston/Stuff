 #CHAPTER 6 - Going Further - 2
 #            Research the lseek system call. Rewrite the add-year program to
 #            open the source file for both reading and writing, and write the
 #            modified records back to the same file they were read from.
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

  movl  %eax, ST_FILE_DESCRIPTOR(%ebp)

 loop_begin:
  pushl ST_FILE_DESCRIPTOR(%ebp)
  pushl $record_buffer
  call  read_record
  addl  $8, %esp

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

  #Write the record out
  pushl ST_FILE_DESCRIPTOR(%ebp)
  pushl $record_buffer
  call  write_record
  addl  $8, %esp

  jmp   loop_begin

 loop_end:
  movl  $SYS_CLOSE, %eax
  movl  ST_FILE_DESCRIPTOR(%ebp), %ebx
  int   $LINUX_SYSCALL

  movl  $SYS_EXIT, %eax
  movl  $0, %ebx
  int   $LINUX_SYSCALL
