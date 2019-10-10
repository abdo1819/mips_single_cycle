# Shift Right Logical:

## introduction:

MIPS also has a **shift right logical** instruction. It moves bits to
the right by a number of positions less than 32. The high-order bit gets
zeros and the low-order bits are discarded.

If the bit pattern is regarded as an unsigned integer, or a positive
two\'s comp. integer, then a right shift of one bit position performs an
integer divide by two. A right shift by N positions performs an integer
divide by 2^N^.

the following is a machine code description for Srl:
```assembly
srl \$rs \$rt shift
```

## Recipe:

mux\[\] (multiplexer): It would select Read data 1(rs) if we\'re not
doing a shift operation, and it would select( rt) if we are doing a
shift operation.

branch Instruction: we would need to branch Instruction\[10:6\] (the
shift amount) off of Instruction\[15:0\], and Instruction\[10:6\] would
then be fed into the other port of the ALU

### implementation:

| option (shift) | operation |
|----------------|------------------------------|
|0               |  output of mux\[1\] equals not doing a shift   |
|1               |  output of mux\[1\] equals doing a shift operation. |

## schmatic

![alt text](srl.BMP)