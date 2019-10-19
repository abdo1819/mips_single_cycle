# addiu logic instruction:

The **addiu** instruction does a anddition of two 32-bit . At
run time the 16-bit immediate operand is sigen extended to make it a 32-bit operand.

## the following is a machine code description for addiu:

```assembly
addiu \$rt, \$rs, immed
```

## implementation:

this design is based on the fact that addiu is identical to addi with deffrent overflow behavior

opcode | control
-------|--------
000101 |10010000000000000000

## schmatic

![alt text](0001.jpg)