module aludec(input logic [5:0] funct,
                input logic [3:0] aluop,
                output logic [3:0] alucontrol);
// assign jr=funct==8;
always_comb
	
    case(aluop)
        4'b0000: alucontrol <= 4'b0010; // add (for lw/sw/addi)
        4'b0001: alucontrol <= 4'b0110; // sub (for beq)
        4'b0010: alucontrol <= 4'b1010; // blez        
        4'b0011: alucontrol <= 4'b0001; // or (for ori)
        4'b0100: alucontrol <= 4'b1000; // shift 16 (LUI)
        4'b0101: alucontrol <= 4'b1001; // xor (for XORI)
        4'b0110: alucontrol <= 4'b0111; // sub (for slti)
        4'b0111: alucontrol <= 4'b0000; // and (for andi)
	     	
        default: case(funct) // R-type instructions
            6'b000000: alucontrol <= 4'b0011; // sll
            6'b100000: alucontrol <= 4'b0010; // add
            6'b100010: alucontrol <= 4'b0110; // sub
            6'b100100: alucontrol <= 4'b0000; // and
            6'b100101: alucontrol <= 4'b0001; // or
            6'b101010: alucontrol <= 4'b0111; // slt
            6'b000010: alucontrol <= 4'b1100; // srl
            6'b000110: alucontrol <= 4'b1011; // srlv
            6'b000011: alucontrol <= 4'b1101; // sra
            default: alucontrol <= 4'bxxxx; // ???
        endcase
    endcase
endmodule