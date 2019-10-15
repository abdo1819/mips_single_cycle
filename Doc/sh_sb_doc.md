##  store half and store byte

### introduction:

a "store half" and "store byte" implementation using MIPS micro-architecture was built upon Harris design in their book (reference)

`sh $ Registering value imm($regRefearingToMemAddress)`

`sb $Registering value imm($regRefearingToMemAddress)`

the following is a machine code description for sh and sb

```
 sh: 101001  $regRefearingToMemAddress $storeReg iiiiiiii iiiiiiii
 sb: 101000  $regRefearingToMemAddress $storeReg iiiiiiii iiiiiiii
```

#### implementation:

this design is based on the fact that `sw` was already implemented and working well so why not to reuse it? at the   controller we make the **MemWr pin** 2 bits and  **WE pin** also 2 bits,

in `sw`the  alu result  is  address  [**32** bit] of the word and to move to the next word we sift the address  left  twice to add **4**  so we always have  **2** bits is **00**  , we use this two bits to  determined which number of bits in data memory to put the value of **reg** according to the following table :

| option ( WE pin) | operation                                                    |
| ---------------- | ------------------------------------------------------------ |
| 0 0              | don't care                                                   |
| 0 1              | store word ,RAM[a[31:2]] <= wd;                              |
| 1 0              | store half word , {a[1],4'b0000}  uses the second LSB as an indeicator to the upper or lower word starting point which is an intuitive approuch to reach the half word |
| 1 1              | store byte , {a[1:0],3'b000} uses the first and second LSB as an indeicator to the specified byte starting point which is an intuitive approuch to reach the byte |


#### schematic:

!["sh sb image"](https://raw.githubusercontent.com/abdo1819/arch_lab09/master/shsb.bmp "Schematic")

#### Code:

refearing to the diff [file](https://github.com/abdo1819/arch_lab09/blob/master/diff__sh_sb.diff)
 to make a quick review to what i've changed/added 

### Reference:

Digital design and computer architecture by David and Sarah Harris
