// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

    // Variables:
    //   R0   :  0 - increment value
    //   R1   :  1 - multiple counter
    //   R2   :  2 - result
    //   R3   :  3 - temporary storage
    //   sign : 16 - sign of result
    //   for  : 17 - counter for for loop
    //

    // Method:
    //   init result with default, 0
    //   init 'sign' with 1
    //   for R0,R1
    //     if R[for] == 0
    //       end
    //     if R[for] < 0
    //       R[for] = -R[for]
    //       'sign' = -'sign'
    //   if R[0] < R[1]
    //     swap(R[0],R[1])
    //   until R[1] < 0
    //     R[2] += R[0]
    //     R[1]--
    //   if 'sign' < 0
    //     result = -result
    //   end
    //

    @R2  // default result
    M=0

    @sign
    M=1

    // for (for=0; for<2; for++)
    @0
    D=A
    @for
    M=D

(FOR)

    @for
    D=M
    @2
    D=D-A
    @ENDFOR
    D;JEQ

    // D = R[for]
    @for
    A=M
    D=M

    @END
    D;JEQ

    @NO_NEG
    D;JGT

    // R[for] = -R[for]
    @for
    A=M
    M=-M

    // 'sign' = -'sign'
    @sign
    M=-M

(NO_NEG)

    @for
    M=M+1
    @FOR
    0;JMP

(ENDFOR)

    // R1 = min(R0,R1)
    @R0
    D=M
    @R1
    D=D-M
    @NO_SWAP
    D;JGE

    @R0
    D=M
    @R3
    M=D

    @R1
    D=M
    @R0
    M=D

    @R3
    D=M
    @R1
    M=D

(NO_SWAP)

(MULTIPLY)

    @R1
    MD=M-1
    @ENDMULT
    D;JLT

    @R0
    D=M
    @R2
    M=D+M

    @MULTIPLY
    0;JMP

(ENDMULT)

    @sign
    D=M
    @END
    D;JGT

    // result = -result
    @R2
    M=-M

(END)   
    @END
    0;JMP

