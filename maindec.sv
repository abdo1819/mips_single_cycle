module maindec(input logic [5:0] op,
    output logic memtoreg, memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,
    output logic ne,
    output logic half,
    output logic b,
    output logic [2:0] aluop,
    output logic lbu);

logic [14:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump, aluop, ne, half, b, lbu} = controls;


always_comb
    case(op)
        6'b000000: controls <= 15'b110000000100000; // RTYPE
        6'b100011: controls <= 15'b100100100000000; // LW
        6'b101011: controls <= 15'b000101000000000; // SW
        6'b000100: controls <= 15'b000010000010000; // BEQ
        6'b001000: controls <= 15'b100100000000000; // ADDI
        6'b001101: controls <= 15'b101100000110000; // ORI
        6'b000010: controls <= 15'b000000010000000; // J
        6'b000101: controls <= 15'b000010000011000;  // BNQ
        6'b100001: controls <= 15'b100100100000100; // LH
        6'b100000: controls <= 15'b100100100000110; // LB
        6'b100100: controls <= 15'b100100000000001; // lbu
        default:   controls <= 15'bxxxxxxxxxxxxxxx; // illegal op

    endcase
endmodule