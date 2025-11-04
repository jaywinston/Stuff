The basic idea is o decrement the input and copy it to the next data block
until it's depleted; then execute the data block; then reverse the process
until (i guess) the input matches the dispatching value (that doesn't make
sense); i also guess that means that i'll have to bring the input value to
every data block and provide work space for the comparison;
Every data block is bounded by null and there's a work buffer between two nulls

prompt
>++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++++++++++ ++
>++++++++++ ++++++++++ ++++++++++ ++

AA
>>>>>>
+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
+++++
>
+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
+++++
BB
>>>>>
+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
+++++ +
>
+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
+++++ +
CC
>>>>>
+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
+++++ ++
>
+++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++ +++++
+++++ ++
<<<<<<<<<<<<<<<<<<<<

print prompt and collect input
.>.>>,

atoi(argv1) for now
----------------
----------------
----------------

[>+>+<<-] save a master copy and a dispatch copy that will be destroyed
>> start dispatch

~?~
