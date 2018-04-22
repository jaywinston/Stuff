 #CHAPTER 6 - Going Further - 5
 #            Write a function called compare-strings that will compare two
 #            strings up to 5 characters.  Then write a program that allows the
 #            user to enter 5 characters, and have the program return all
 #            records whose first name starts with those 6 characters.
 #
 #PURPOSE:  Compare two strings, s and t. Return 1 if they match or 0 if not.
 #
 #VARIABLES:    %eax - Holds the return value, 1, from the start of
 #                     the function as the default return value.
 #              %ebx - Holds s
 #              %ecx - Holds t
 #              %dl  - Holds (%ebx,%edi,1)
 #              %dh  - Holds (%ecx,%edi,1)
 #              %edi - Holds the index during iteration
 #              8(%ebp) - Holds s argument
 #              12(%ebp) - Holds t argument
 #
 #METHOD:	- $1 is moved into %eax as a default return value.  If a non-match
 #              is found, then $0 is moved into %eax.
 #          - $s is moved from 8(%ebp) to %ebx.
 #          - $t is moved from 12(%ebp) to %ecx.
 #          - %edi is initialized to $0.
 #          - A loop starts in which %edi is compared to $5.  If equal, then
 #              jump to the function conclusion.
 #          - (%ebx,%edi,1), s[%edi], is moved into %dl.
 #          - (%ecx,%edi,1), t[%edi], is moved into %dh.
 #          - %edi is incremented.
 #          - %dl is compared to %dh.  If they match, then reiterate.
 #              Otherwise, continue out of the loop, move $0 into %eax
 #              and continue through the function conclusion.
 #

  .equ ST_STR_S, 8
  .equ ST_STR_T, 12

  .globl compare_strings
  .type compare_strings, @function
 compare_strings:

  pushl %ebp
  movl  %esp, %ebp

  #initialize variables
  movl  $1, %eax                # default: match
  movl  ST_STR_S(%ebp), %ebx    # %ebx <- s
  movl  ST_STR_T(%ebp), %ecx    # %ecx <- t
  movl  $0, %edi

 comp_loop:
  cmpl  $5, %edi            # End of string?
  je    return              # yes, goto end
  movb  (%ebx,%edi,1), %dl  # %dl <- s[%edi]
  cmpb  $0, %dl             # s[%edi] == 0?
  je    return              # yes, goto end
  movb  (%ecx,%edi,1), %dh  # %dh <- t[%edi]
  incl  %edi
  cmpb  %dh, %dl            # s[%edi] == t[%edi] ?
  je    comp_loop           # yes, continue

  movl  $0, %eax            # no match

 return:                    # function conclusion
  movl  %ebp, %esp
  popl  %ebp

  ret
