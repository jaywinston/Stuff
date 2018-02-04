 #CHAPTER 7 - Use the Concepts - 3
 #  Add a recovery mechanism for add-year.s that allows it to read from STDIN
 #  if it cannot open the standard file
 #

  .include "linux.s"
  .include "record-def.s"

  .section .data
 output_file_name:
  .ascii "testout.dat\0"
 prompt:
  .ascii "input file name> "

  .equ MAX_FILE_NAME, 256

  .section .bss
  .lcomm input_file_name, MAX_FILE_NAME
  .lcomm record_buffer, RECORD_SIZE

  #Stack offsets of local variables
  .equ ST_INPUT_DESCRIPTOR, -4
  .equ ST_OUTPUT_DESCRIPTOR, -8

  .section .text
  .globl _start
 _start:
  #Copy stack pointer and make room for local variables
  movl  %esp, %ebp
  subl  $8, %esp

  #move 'test.dat' into input_file_name
  movl  $0, %edi
  movb  $'t', input_file_name(,%edi,1)
  incl  %edi
  movb  $'e', input_file_name(,%edi,1)
  incl  %edi
  movb  $'s', input_file_name(,%edi,1)
  incl  %edi
  movb  $'t', input_file_name(,%edi,1)
  incl  %edi
  movb  $'.', input_file_name(,%edi,1)
  incl  %edi
  movb  $'d', input_file_name(,%edi,1)
  incl  %edi
  movb  $'a', input_file_name(,%edi,1)
  incl  %edi
  movb  $'t', input_file_name(,%edi,1)
  incl  %edi
  movb  $0, input_file_name(,%edi,1)

  #Open file for reading
 try_open:

  #try the buffer
  movl  $SYS_OPEN, %eax
  movl  $input_file_name, %ebx
  movl  $0, %ecx
  movl  $0666, %edx
  int   $LINUX_SYSCALL

  #check if file opened
  cmpl  $0, %eax
  jge   good_open

  #if not, then get file name
  #prompt user
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $prompt, %ecx
  movl  $17, %edx
  int   $LINUX_SYSCALL

  #get file name
  movl  $SYS_READ, %eax
  movl  $STDIN, %ebx
  movl  $input_file_name, %ecx
  movl  $MAX_FILE_NAME, %edx
  int   $LINUX_SYSCALL

  #if last byte is not newline, then file name is too long
  decl  %eax
  cmpb  $10, input_file_name(,%eax,1)
  je    good_name

  ###FILENAME TOO LONG ERROR HANDLER###
  .section .data
 err_msg:
  .ascii "file name too long\n"
  .section .text
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $err_msg, %ecx
  movl  $19, %edx
  int   $LINUX_SYSCALL

  #exit program
  movl  $MAX_FILE_NAME, %ebx
  movl  $SYS_EXIT, %eax
  int   $LINUX_SYSCALL
  ###END ERROR HANDLER###

 good_name:
  #terminate file name with '\0'
  movb  $0, input_file_name(,%eax,1)

  jmp   try_open

 good_open:

  movl  %eax, ST_INPUT_DESCRIPTOR(%ebp)

  #Open file for writing
  movl  $SYS_OPEN, %eax
  movl  $output_file_name, %ebx
  movl  $0101, %ecx
  movl  $0666, %edx
  int   $LINUX_SYSCALL

  movl  %eax, ST_OUTPUT_DESCRIPTOR(%ebp)

 loop_begin:
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
  jne   loop_end

  #Increment the age
  incl  record_buffer + RECORD_AGE

  #Write the record out
  pushl ST_OUTPUT_DESCRIPTOR(%ebp)
  pushl $record_buffer
  call  write_record
  addl  $8, %esp

  jmp   loop_begin

 loop_end:
  movl  $SYS_EXIT, %eax
  movl  $0, %ebx
  int   $LINUX_SYSCALL
