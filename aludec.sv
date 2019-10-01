module aludec(input logic [5:0] funct,
                input logic [2:0] aluop,
                output logic [3:0] alucontrol,
                output logic shiftReg);

always_comb
    case(aluop)
        3'b000: {alucontrol,shiftReg} <= 5'b00100; // add (for lw/sw/addi)
        3'b001: {alucontrol,shiftReg} <= 5'b01100; // sub (for beq)
        3'b011: {alucontrol,shiftReg} <= 5'b00010; // or (for ori)
        default: case(funct) // R-type instructions
            6'b100000: {alucontrol,shiftReg} <= 5'b00100; // add
            6'b100010: {alucontrol,shiftReg} <= 5'b01100; // sub
            6'b100100: {alucontrol,shiftReg} <= 5'b00000; // and
            6'b100101: {alucontrol,shiftReg} <= 5'b00010; // or
            6'b101010: {alucontrol,shiftReg} <= 5'b01110; // slt
            6'b000010: {alucontrol,shiftReg} <= 5'b10001; // srl
            default:   {alucontrol,shiftReg} <= 5'bxxxxx; // ???
        endcase
    endcase
endmodule