// Marion Geary
// December 8, 2021

// Create for loop
MOVI 18 r5 // i = 18
loop:
MOVI 25 r6 
SUB r5 r6 // check i <= 24 (implemented as i < 25)
MOVI loopHelp r8
JNZ r6 r8 // continue loop if condition met
HALT // if condition not met, end program

loopHelp:
MOVI 180 r2 // a = 180
PUSH r2
PUSH r5 // b = i
MOVI gcd r4
JAL r4 // call gcd(a, b)

OUT r1 // print gcd(a, b)
MOVI 1 r7
ADD r7 r5 // i++

MOVI loop r4
JMP r4 // repeat the loop

// Mod function mod(a, b) = a mod b
mod:
PUSH fp
MOV sp fp
PUSH rp

LDLO -3 r1
LDLO -2 r2 // create 2 local variables for a and b

// a mod b = a - ((a / b) * b)
MOV r1 r3
IDIV r2 r3
MUL r2 r3
MOV r1 r2
SUB r3 r2

MOV r2 r1 // put outcome in r1 to return a mod b

POP rp
POP fp
RET

gcd:
PUSH fp
MOV sp fp
PUSH rp

MOVI 2 r2
ADD r2 sp // make room for 2 local variables -> a & b

LDLO -3 r2 // r2 = a
STLO 1 r2 // save a as local variable
LDLO -2 r3 // r3 = b
STLO 2 r3 // save b as local variable

// conditional
MOVI then r4
JNZ r3 r4 // if b != 0, jump to then

// base case -> b == 0
MOV r2 r1 // return a by loading a in r1

MOVI 2 r2
SUB r2 sp // remove local variables from stack

POP rp
POP fp
RET

// recursive case
then:
PUSH r3 // push b as first argument in gcd
PUSH r2 // a for mod
PUSH r3 // b for mod

MOVI mod r8 
JAL r8 // call a mod b

POP r8
POP r8 // get rid of argument for call to mod

PUSH r1 // push a mod b as second argument in gcd

MOVI gcd r8 // call gcd(b, a mod b)
JAL r8

MOVI 4 r3
SUB r3 sp // remove pushed variables
 
POP rp
POP fp
RET




