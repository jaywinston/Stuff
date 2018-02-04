  .include "linux.s"
  .include "record-def.s"

 #CHAPTER 6 - Use the Concepts - 2
 #            Create a program that uses a loop to write 30 identical
 #            records to a file.
 #
 #VARIABLES:    record1 - the record
 #              file_name - the output file name
 #              ST_FD(%ebp) - the open file descriptor
 #

  #access to the file descriptor on the stack
  .equ ST_FD, -4

 file_name:
  .ascii "records.dat\0"

 #the record
 record1:
  .ascii "Frederick\0"
  .rept 30 #Padding to 40 bytes
  .byte 0
  .endr

  .ascii "Bartlett\0"
  .rept 31 #Padding to 40 bytes
  .byte 0
  .endr

  .ascii "4242 S Prairie\nTulsa, OK 55555\0"
  .rept 209 #Padding to 240 bytes
  .byte 0
  .endr

  .long 45

  .globl _start
 _start:

  movl  %esp, %ebp
  #a place for the file descriptor
  subl  $4, %esp

  #open the file
  movl  $SYS_OPEN, %eax
  movl  $file_name, %ebx
  movl  $0101, %ecx
  movl  $0660, %edx
  int   $LINUX_SYSCALL

  #save the file descriptor
  movl  %eax, ST_FD(%ebp)

  #the loop
  .rept 30
  #write to the open file
  movl  $SYS_WRITE, %eax
  movl  ST_FD(%ebp), %ebx
  movl  $record1, %ecx
  movl  $RECORD_SIZE, %edx
  int   $LINUX_SYSCALL
  .endr

  #close the file
  movl  $SYS_CLOSE, %eax
  movl  ST_FD(%ebp), %ebx
  int   $LINUX_SYSCALL

  movl  $SYS_EXIT, %eax
  movl  $0, %ebx
  int   $LINUX_SYSCALL
