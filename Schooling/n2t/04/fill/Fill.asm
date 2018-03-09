// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

    // upper screen bound
    @24576  
    D=A
    @scrn_hi
    M=D

(MAIN)

    @KBD
    D=M
    @NO_PRESS
    D;JEQ

    @color
    M=-1

    @PAINT
    0;JMP

(NO_PRESS)

    @color
    M=0

(PAINT)

    @KBD
    M=0

    @SCREEN
    D=A
    @cursor
    M=D

(FILL)

    @cursor
    D=M
    @scrn_hi
    D=D-M
    @MAIN
    D;JEQ

    @color
    D=M
    @cursor
    A=M
    M=D

    @cursor
    M=M+1

    @FILL
    0;JMP
