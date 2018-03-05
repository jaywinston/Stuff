  .globl _start
 _start:
  pushl	$0x00000a21
  pushl $0x646c726f
  pushl $0x77202c6f
  pushl $0x6c6c6548

  movl	$4, %eax
  movl	$1, %ebx
  movl	%esp, %ecx
  movl	$14, %edx
  int	$0x80

  movl	$1, %eax
  int	$0x80
