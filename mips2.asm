#Assembly Code
main: ori $t0, $0, 0x8000      #34088000
      addi $t1, $0, -32768     #20098000
      ori $t2, $t0, 0x8001     #350a8001
      beq $t0, $t1, there      #11090005
      slt $t3, $t1, $t0        #0128582a
      bne $t3, $0, here        #15600001
      j there                  #08100009 --
here: sub $t2, $t2, $t0        #01485022
      ori $t0, $t0, 0xFF       #350800ff
      there: add $t3, $t3, $t2 #016a5820
      sub $t0, $t2, $t0        #01484022
      sw $t0,s          #ad680052