this does not handle empty strings

the message buffers are
  ; each string buffer is delimited by \0
  ; go the char immediately left of that
  ; copy that char to the cells two and one to the right
  ; the cell one to the right is now the stop condition
  ; the cell two to the right is now in the 'message buffer'
  ; if a difference is found then he message may need to be reconstructed from
    the original and the message buffer; that is accomplished by printing
    what ever may be in the original buffer then moving right two cells and
    then printing whatever may be in the message buffer

 +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++  '&lt;'
>+++++ +++++ +++++ +++++ +++++ +++++ ++                                   ' '

<...>.                     prompt
>>                         move to buffer1
,----------[>,----------]  read until ascii \n
<[<]<                      move back to prompt string
<...>.                     prompt
>>[>]>>>>>                 move to buffer2
,----------[>,----------]  read until ascii \n
<[<]<<<<<                  move to end of buf1
[
  [>+>+<<-]         copy buf1 lastchar to condition and message buffer
  >[[>]>+<<[<]>-]   copy to comp area
  >[>]>>>[>]<       move to end of buf2
  [>+>+<<-]         copy buf2 lastchar to condition and message buffer
  >[<<[<]<->>[>]>-] compare
  <<[<]<[  diff
    <<[<]<<[<]>[++++++++++.>]>>[++++++++++.>]++++++++++.  echo buf1
    >>>[++++++++++.>]>>[++++++++++.>]++++++++++.          echo buf2
    [>]>>>>  exit
  ]
  <<[<]<<
]
