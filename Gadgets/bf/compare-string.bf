the message buffers are
  • each string buffer is delimited on both sides by \0
  • go the char immediately left of that
  • copy that char to the cells two and three to the right
  • the cell one to the right is now the demarcator of the current character
  • the cell two to the right is now the stop condition
  • the cell three to the right is now in the 'message buffer'
  • the stop condition is to stop modifying the comparison cell ie move
    the 'stop condition' to the comparison cell
  • the demarcator is updated when the stop condition is nulled by moving it to
    the comparison cell
  • if a difference is found then the string may need to be reconstructed from
    the original and message buffers; that is accomplished by printing
    whatever may be in the original buffer then moving right two cells and
    then printing whatever may be in the message buffer


UI constants
colors
 +++++++++++++++++++++++++++  \033
>++++++++++++++++++++++++++++++++++++++++++++++
 +++++++++++++++++++++++++++++++++++++++++++++  left bracket
>+++++++++++++++++++++++++++++++++++++++++++++++++++ '3'
>++++++++++++++++++++++++++++++++++++++++++++++++++  '2'
>+++++++++++++++++++++++++++++++++++++++++++++++++   '1'
>++++++++++++++++++++++++++++++++++++++++++++++++    '0'
>+++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++  'm'
nice decorations
>+++++++++++++++++++++++++++++++++++++++++++++  minus
>+++++++++++++++++++++++++++++++++++++++++++    plus
prompt
>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  '&lt;'
>++++++++++++++++++++++++++++++++                              ' '

<...>.                     prompt
>>                         go to buffer1
,----------[>,----------]  read until ascii \n
<[++++++++++<]<            go to prompt restoring data (lazy eval aint worth)
<...>.                     prompt
>>[>]>>>>>                 go to buffer2
,----------[>,----------]  read until ascii \n
<[++++++++++<]<<<<<        go to end of buf1 restoring data
[  compare
  [>+>+<<-]          copy buf1 lastchar to condition and message buffer
  >[[>]>+<<[<]>-]    move condition to comparison cell
  >[>]>>>[>]<        go to end of buf2
  [>+>+<<-]          copy buf2 lastchar to condition and message buffer
  >[<<[<]<->>[>]>-]  subtract condition from comparison cell
  >[<]               conditionally compensate for empty string 2
  <<[<]<[            go to comparison cell
    s2 is not longer than s1 (see below)
    <<[<]<<[<]  go to start of buf1
    fancy shmancy colors; yeah
    ((\033 leftbracket) = (CSI)) 3 1 m 'minus' CSI 0 m ' '
    <<<<<<<<<<<.>.>.>>.>>.>.<<<<<<<.>.>>>>.>.>>>>.
    >>[.>]>>[.>]++++++++++.  echo s1
    CSI 3 2 m 'plus' CSI 0 m ' '
    [<]<<[<]<<<<<<<<<<<.>.>.>.>>>.>>.<<<<<<<<.>.>>>>.>.>>>>.
    >>[>]>>[>]>[.>]>>[.>]++++++++++. echo s2
    >>>>>  exit
  ]
  <<[<]<<  go to start of buf1
]
>>>[  go to start of msg1
  buf1 is empty but msg1 is not
  [>]>>>[  go to start buf2
    buf2 is not empty therefore s2 is longer than s1
    so report diff and exit
    <<<<[<]<<<<<<<<<<<<<.>.>.>>.>>.>.<<<<<<<.>.>>>>.>.>>>>.
    >>>>[.>]++++++++++.
    [<]<<<<<<<<<<<<<.>.>.>.>>>.>>.<<<<<<<<.>.>>>>.>.>>>>.
    >>>>[>]>>[.>]>>[.>]++++++++++.
    >>>> exit
  ]<<<  go to start of msg1
]
s1 is empty so check s2 or the program's exited and nothing will happen
>>>[
  <<<<<<<<<<<<<<<<<.>.>.>>.>>.>.<<<<<<<.>.>>>>.>.>>>>. ' ' deliberately
  >++++++++++.
  <<<<<<<<<<<.>.>.>.>>>.>>.<<<<<<<<.>.>>>>.>.>>>>.
  >>>>>>>[.>]++++++++++.  echo s2
  >  exit
]
