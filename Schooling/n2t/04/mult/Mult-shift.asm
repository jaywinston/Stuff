    @R2
    M=0

    @R0
    D=M
    @16
    D=D-A
    @ADD
    D;JLT

    @R1
    D=M
    @16
    D=D-A
    @ADD
    D;JLT

    @R3
    M=1

    @count
    M=0

(L2)

    @R1
    D=M
    @R3
    D=D&M
    @NO
    D;JEQ

    @R0
    D=M
    @R2
    M=D+M

(NO)

    @R0
    D=M
    M=D+M

    @R3
    D=M
    M=D+M

    @count
    MD=M+1
    @16
    D=D-A
    @L2
    D;JNE


(ADD)

    @R0
    D=M
    @R1
    D=D-M
    @NOSWAP
    D;JGE

    @R0
    D=M
    @temp
    M=D
    @R1
    D=M
    @R0
    M=D
    @temp
    D=M
    @R1
    M=D

(NOSWAP)
(L1)

    @R1
    D=M
    @END
    D;JEQ

    @R0
    D=M
    @R2
    M=D+M

    @R1
    M=M-1

    @L1
    0;JMP
    @END
    0;JMP

(END)
    @END
    0;JMP
