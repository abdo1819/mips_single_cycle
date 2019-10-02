module maindec(input logic [5:0] op,
    output logic memtoreg, memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,
    output logic ne,
    output logic [2:0] aluop);

logic [11:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump, aluop, ne} = controls;


always_comb
    case(op)
        6'b000000: controls <= 12'b110000000100; // RTYPE
        6'b100011: controls <= 12'b100100100000; // LW
        6'b101011: controls <= 12'b000101000000; // SW
        6'b000100: controls <= 12'b000010000010; // BEQ
        6'b001000: controls <= 12'b100100000000; // ADDI
        6'b001101: controls <= 12'b101100000110; // ORI
        6'b000010: controls <= 12'b000000010000; // J
        6'b000101: controls <= 12'b000010000011;  // BNQ
        6'b000000: controls <= 12'b000010000011;  // andi
        default: controls <= 9'bxxxxxxxxx; // illegal op
    endcase
endmodule