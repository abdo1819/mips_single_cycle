module aludec(input logic [5:0] funct,
                input logic [2:0] aluop,
                output logic [3:0] alucontrol,output logic jr,output logic spregwrite);
assign jr=funct==8;
assign spregwrite=funct==27;
always_comb
	
    case(aluop)
        3'b000: alucontrol <= 4'b0010; // add (for lw/sw/addi)
        3'b001: alucontrol <= 4'b0110; // sub (for beq)
        3'b011: alucontrol <= 4'b0001; // or (for ori)
        3'b100: alucontrol <= 4'b0000; // and (for andi)
        default: case(funct) // R-type instructions
            6'b100000: alucontrol <= 4'b0010; // add
            6'b100010: alucontrol <= 4'b0110; // sub
            6'b100100: alucontrol <= 4'b0000; // and
            6'b100101: alucontrol <= 4'b0001; // or
            6'b101010: alucontrol <= 4'b0111; // slt
            6'b000010: alucontrol <= 4'b1000; // srl
            default: alucontrol <= 3'bxxx; // ???
        endcase
    endcase
endmodule