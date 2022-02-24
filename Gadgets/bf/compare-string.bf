the message buffers are
  ; each string buffer is delimited by \0
  ; go the char immediately left of that
  ; copy that char to the cells one and two to the right
  ; the cell one to the right is now the stop condition
  ; the cell two to the right is now in the 'message buffer'
  ; if a difference is found then the message may need to be reconstructed from
    the original and the message buffer; that is accomplished by printing
    what ever may be in the original buffer then moving right two cells and
    then printing whatever may be in the message buffer

ctrl F and ctrl H hang the program; ctrl R comes as \012 on gnome terminal;
I haven't tested all control chars
Oh; that's bc they're less than \n; i have no intention on handling
this any time soon

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
>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++  '&lt;'
>++++++++++ ++++++++++ ++++++++++ ++                                ' '

<...>.                     prompt
>>                         go to buffer1
,----------[>,----------]  read until ascii \n
<[<]<                      go to prompt
<...>.                     prompt
>>[>]>>>>>                 go to buffer2; skipping null|comparison cell|null
,----------[>,----------]  read until ascii \n
<[<]<<<<<                  go to end of buf1
[  compare
  [>+>+<<-]          copy buf1 lastchar to condition and message buffer
  >[[>]>+<<[<]>-]    move condition to comparison cell
  >[>]>>>[>]<        go to end of buf2
  [>+>+<<-]          copy buf2 lastchar to condition and message buffer
  >[<<[<]<->>[>]>-]  subtract condition from comparison cell
  >[<]               conditionally compensate for empty string 2
  <<[<]<[            go to comparison cell
    s1 and s2 are non empty
    <<[<]<<[<]  go to start of buf1
    fancy shmancy colors; yeah
    <[<]>.>.>.>>.>>.>.[<]>.>.>>>>.>.>>>>.>
    >[++++++++++.>]>>[++++++++++.>]++++++++++.  echo s1
    [<]<<[<]
    <[<]>.>.>.>.>>>.>>.[<]>.>.>>>>.>.>>>>.>
    >[>]>>[>] go to null immediately left of buf2
    >[++++++++++.>]>>[++++++++++.>]++++++++++. echo s2
    [>]>>>>  exit
  ]
  <<[<]<<  go to start of buf1
]
>>>[  go to start of msg1
  s1 not empty
  [>]>>>[  go to start buf2
    data still in buf2 which means that s2 is longer than s1
    so report diff and exit
    <<<<[<]
    <<<[<]>.>.>.>>.>>.>.[<]>.>.>>>>.>.>>>>.>
    >>>[++++++++++.>]++++++++++.>>
    <<[<]<<<[<]>.>.>.>.>>>.>>.[<]>.>.>>>>.>.>>>>.>>
    >>[>]>
    >[++++++++++.>]>>[++++++++++.>]++++++++++.
    >>>> exit
  ]<<<  go to start of msg1
]
s1 is empty so check s2 or the program's exited and nothing will happen
>>>[  check for non empty string 2
  <<<<<<<[<]>.>.>.>>.>>.>.[<]>.>.>>>>.>.>>>>.>++++++++++.
  [<]>.>.>.>.>>>.>>.[<]>.>.>>>>.>.>>>>.
  >>>>>>>[++++++++++.>]++++++++++.  echo s2
  >  exit
]
