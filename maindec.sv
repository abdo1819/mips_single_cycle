module maindec(input logic [5:0] op,
    output logic memtoreg, memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,
    output logic ne,
    output logic half,
    output logic b,
    output logic [2:0] aluop);

logic [13:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump, aluop, ne, half, b} = controls;


always_comb
    case(op)
        6'b000000: controls <= 14'b11000000010000; // RTYPE
        6'b100011: controls <= 14'b10010010000000; // LW
        6'b101011: controls <= 14'b00010100000000; // SW
        6'b000100: controls <= 14'b00001000001000; // BEQ
        6'b001000: controls <= 14'b10010000000000; // ADDI
        6'b001101: controls <= 14'b10110000011000; // ORI
        6'b000010: controls <= 14'b00000001000000; // J
        6'b000101: controls <= 14'b00001000001100;  // BNQ
        6'b100001: controls <= 14'b10010010000010; // LH
        6'b100000: controls <= 14'b10010010000011; // LB
        default:   controls <= 14'bxxxxxxxxxxxxxx; // illegal op

    endcase
endmodule