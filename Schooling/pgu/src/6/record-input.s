 #CHAPTER 6 - Going Further - 4
 #           Write a program that will add a single record to the file by
 #           reading the data from the keyboard.
 #
 #VARIABLES:    record_buffer - Holds the record as it is being collected from
 #                             the user
 #              file_name - Holds the output file name
 #              firstname_prompt - Holds the prompt for the first name field
 #              lastname_prompt - Holds the prompt for the last name field
 #              address_no_st_prompt - Holds the prompt for the first half of
 #                                     the address field
 #              address_city_st_zip_prompt - Holds the prompt for the second
 #                                           half of the address field
 #              -4(%ebp) - Holds the file descriptor
 #NOTES:    This program collects each field by reading STDIN directly into a
 #          record buffer at the offset of that field.  It then appends the
 #          whole buffer to the output file.
 #              The OS seems to handle passing STDIN to the program.  I don't
 #          know how to change that or even if I should, perhaps the author of
 #          the exercise knew this.  But that is the reason that I prompt the
 #          user for each field.
 #

  .include "linux.s"
  .include "record-def.s"

  .section .bss

  .section .data

 file_name:
  .ascii "input.dat\0"

 record_buffer:
  .rept RECORD_SIZE - 4
  .byte 0
  .endr
  .long 34  #default age

 firstname_prompt:
  .ascii "Enter first name> "
 lastname_prompt:
  .ascii "Enter last name> "
 address_no_st_prompt:
  .ascii "Enter address\nHouse number Street name> "
 address_city_st_zip_prompt:
  .ascii "City, State Zip code> "

  .section .text

  .equ READ_SIZE_SHORT, 39
  .equ READ_SIZE_LONG, 199
  .equ NEWLINE, 10

  .equ ST_FD, -4

  .globl _start
 _start:

  movl  %esp, %ebp

  subl  $4, %esp

  ###COLLECT EACH FIELD FROM THE USER###
  ###PROMPT USER FOR FIRST NAME###
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $firstname_prompt, %ecx
  movl	$18, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  ###COLLECT INPUT###
  movl  $SYS_READ, %eax
  movl  $STDIN, %ebx
  movl  $record_buffer, %ecx
  movl  $READ_SIZE_SHORT, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  pushl %eax

  #inspect one byte past the data read, if it's not null
  #then there's data to be discarded on STDIN
  cmpl  $0, record_buffer(,%eax,1)
  je    no_trunc_1
  call  truncate_in
 no_trunc_1:

  #null out a trailing newline
  popl  %eax  #last read length
  decl  %eax  #last byte read
  #if input ends with newline then overwrite it with null
  cmpl  $NEWLINE, record_buffer(,%eax,1)
  jne   no_null_1
  movb  $0, record_buffer(,%eax,1)
 no_null_1:


  ###PROMPT USER FOR LAST NAME###
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $lastname_prompt, %ecx
  movl	$17, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  ###COLLECT INPUT###
  movl  $SYS_READ, %eax
  movl  $STDIN, %ebx
  movl  $record_buffer+RECORD_LASTNAME, %ecx
  movl  $READ_SIZE_SHORT, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  pushl %eax

  #truncate?
  cmpl  $0, record_buffer+RECORD_LASTNAME(,%eax,1)
  je    no_trunc_2
  call  truncate_in
 no_trunc_2:

  #null out a trailing newline
  popl  %eax
  decl  %eax
  cmpl  $NEWLINE, record_buffer+RECORD_LASTNAME(,%eax,1)
  jne   no_null_2
  movb  $0, record_buffer+RECORD_LASTNAME(,%eax,1)
 no_null_2:

  ###PROMPT USER FOR ADDRESS - HOUSE NO AND STREET NAME###
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $address_no_st_prompt, %ecx
  movl	$40, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  ###COLLECT INPUT###
  movl  $SYS_READ, %eax
  movl  $STDIN, %ebx
  movl  $record_buffer+RECORD_ADDRESS, %ecx
  movl  $READ_SIZE_LONG, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  pushl %eax

  #truncate?
  cmpl  $0, record_buffer+RECORD_ADDRESS(,%eax,1)
  je    no_trunc_3
  call  truncate_in
 no_trunc_3:

  #keep newline, this is in the middle of a field

  ###PROMPT USER FOR ADDRESS - CITY, STATE, ZIP CODE###
  movl  $SYS_WRITE, %eax
  movl  $STDOUT, %ebx
  movl  $address_city_st_zip_prompt, %ecx
  movl	$22, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  #offset into RECORD_ADDRESS
  popl  %ecx  #read length of first address input
  movl  $READ_SIZE_LONG, %edx
  #READ_SIZE_LONG - read length of first address input = read length for second
  #                                                      address input
  subl  %ecx, %edx
  #RECORD_ADDRESS + read length of first address input = offset into buffer
  addl  $record_buffer+RECORD_ADDRESS, %ecx
  pushl %ecx  #save for end-of-input checks
  movl  $STDIN, %ebx
  movl  $SYS_READ, %eax
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  #offset into RECORD_ADDRESS + last read length = end of input
  popl  %ecx  #saved offset into RECORD_ADDRESS
  addl  %ecx, %eax

  pushl %eax

  #truncate?
  cmpl  $0, (%eax)
  je    no_trunc_4
  call  truncate_in
 no_trunc_4:

  #null out a trailing newline
  popl  %eax
  decl  %eax
  cmpl  $NEWLINE, (%eax)
  jne   no_null_4
  movb  $0, (%eax)
 no_null_4:

  ###WRITE THE BUFFER TO A FILE###
  ###OPEN THE FILE###
  movl  $SYS_OPEN, %eax
  movl  $file_name, %ebx
  movl  $02101, %ecx
  movl  $0660, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  #store file descriptor
  movl  %eax, ST_FD(%ebp)

  ###WRITE TO THE FILE###
  movl  $SYS_WRITE, %eax
  movl  ST_FD(%ebp), %ebx
  movl  $record_buffer, %ecx
  movl  $RECORD_SIZE, %edx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  ###CLOSE THE FILE###
  movl  $SYS_CLOSE, %eax
  movl  ST_FD(%ebp), %ebx
  int   $LINUX_SYSCALL

  #check for error
  cmpl  $0, %eax
  jl    err_

  #Exit
  movl  $0, %ebx
  movl  $SYS_EXIT, %eax
  int   $LINUX_SYSCALL

  #goto error handler
 err_:
  pushl %eax
  call  exit_on_err


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
