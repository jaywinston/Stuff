 #CHAPTER 6 - Going Further - 5
 #            Write a function called compare-strings that will compare two
 #            strings up to 5 characters.  Then write a program that allows the
 #            user to enter 5 characters, and have the program return all
 #            records whose first name starts with those 6 characters.
 #
 #VARIABLES:    -4(%ebp) - Holds the record-file file descriptor
 #              filename - Holds a string constant for the record-file name
 #              prompt - Holds a string constant for the input prompt
 #              input_buffer - Holds the user input
 #              record_buffer - Holds the current record
 #
 #METHOD:   - Open the file of records.
 #          - Collect input from user.
 #          - Loop through records in the file calling compare-strings on the
 #              user input and first name field of the record each iteration.
 #              - Call read-record to get each record.
 #          - On a match, write the record to STDOUT using write-record.
 #

  .include "linux.s"
  .include "record-def.s"

  .equ ST_FD, -4
  .equ NEWLINE, 10

  .section .data
 filename:
  #.ascii "test.dat\0"
  .ascii "input.dat\0"
 prompt:
  .ascii "Enter search string> "

  .section .bss
  .lcomm input_buffer, 6
  .lcomm record_buffer, RECORD_SIZE

  .section .text

  .globl _start
 _start:

  movl  %esp, %ebp
  subl  $4, %esp

  ###OPEN THE RECORD-FILE###
  movl  $SYS_OPEN, %eax
  movl  $filename, %ebx
  movl  $0, %ecx  # read only
  movl  $0666, %edx
  int   $LINUX_SYSCALL

  cmpl  $0, %eax
  jl    err_

  movl  %eax, ST_FD(%ebp)

  ###PROMPT THE USER###
  movl  $SYS_WRITE, %eax
  movl  $STDERR, %ebx
  movl  $prompt, %ecx
  movl  $21, %edx
  int   $LINUX_SYSCALL

  cmpl  $0, %eax
  jl    err_

  ###COLLECT INPUT###
  movl  $SYS_READ, %eax
  movl  $STDIN, %ebx
  movl  $input_buffer, %ecx
  movl  $6, %edx
  int   $LINUX_SYSCALL

  cmpl  $0, %eax
  jl    err_

  ###CONDITION INPUT###
  decl  %eax                            # last byte read
  cmpb  $NEWLINE, input_buffer(,%eax,1) # If the last byte read is not newline,
  je    no_trunc                        # then there is input on STDIN that
  call  truncate_in                     # needs to be discarded.
  jmp   no_null
 no_trunc:
  movb  $0, input_buffer(,%eax,1)       # Otherwise, replace newline with null
 no_null:                               # because the input might be less than
                                        # 5 bytes,
 read_loop:
  ###READ A RECORD###
  pushl ST_FD(%ebp)
  pushl $record_buffer
  call  read_record
  addl  $8, %esp

  # If bytes read doesn't match
  # RECORD_SIZE, then it's either
  # an error or EOF.
  # Either way, exit.
  cmpl  $RECORD_SIZE, %eax
  jne   finished_reading

  ###CHECK FOR A MATCH###
  pushl $record_buffer
  pushl $input_buffer
  call  compare_strings
  addl  $8, %esp
  cmpl  $1, %eax
  jne   no_match

  ###RETURN THE RECORD###
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $record_buffer, %ecx
  movl  $RECORD_SIZE, %edx
  int   $LINUX_SYSCALL

 no_match:

  jmp   read_loop
  
 finished_reading:

exit:
  movl  $SYS_EXIT, %eax
  int   $LINUX_SYSCALL

 err_:
  pushl %eax
  call	exit_on_err


 #PURPOSE:  Discard any remaining input
 #
 #INPUT:    none
 #
 #VARIABLES:    -4(%ebp) - A place to read to.
 #

  .equ ST_DISCARD_BUF, -1
  .equ NEWLINE, 10

 truncate_in:
  pushl %ebp
  movl  %esp, %ebp

  subl  $1, %esp  #a place to read to

 truncate:
  movl  $SYS_READ, %eax
  movl  $STDIN, %ebx
  movl  %ebp, %ecx
  #ST_DISCARD_BUF is negative so add, not subtract
  addl  $ST_DISCARD_BUF, %ecx
  movl  $1, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  cmpb  $NEWLINE, ST_DISCARD_BUF(%ebp)
  jne   truncate

  movl  %ebp, %esp
  popl  %ebp

  ret
