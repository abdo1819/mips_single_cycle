# sllv ( Shift Word Left Logical Variable)

## introduction:

sllv an (R type) instraction for shifting left a word by varible number

### machine code
![sllv machine code divsion](img/sllv_machine.png)

| opcode | function|
|--------------|------------|
| 000000 | 000100 |

### asembly format
```asm
sllv rd, rs, rt
```
## operation
sllv would shit the value in reg(rs) ,by a number stored in low five bits in reg(rt),saving result in reg(rd)

## implentaion
- add sllv operation in alu 

### controls [r-type_controls](../control.csv)
|signal 	|value|
|-----------|-----|
|REgWrite   |	1|
|RegDST |	0|
|ALUSrc |	11|
|Branch |	0|
|MemWrite   |	0|
|MemtoReg   |	0|
|Jump   |	0|
|jr |	0|
|aluop  |	1111|
|ne |	0|
|half   |	0|
|b  |	0|
|lbu    |	0|
|link   |	0|
## code changes:

### [alu.sv](../alu.sv)
add shift left operationg
```systemverlog
y = b << a[4:0]
```
### [aludec.sv](../aludec.sv)

chage the alucontrol to sllv 

| function    | alucontrol|
|-------------|----------------|
| 000100      |  < sllv operation >| 

#### schematic:

![alt text](0001.jpg "Schematic")


### Reference:
[MIPS® Architecture for Programmers set manulal 2016](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf) 
`pg377`
