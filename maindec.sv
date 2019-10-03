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
    output logic lbu, oneZero, link);

logic [16:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump, aluop, ne, half, b, lbu, oneZero, link} = controls;


always_comb
    case(op)
        6'b000000: controls <= 17'b11000000010000010; // RTYPE
        6'b100011: controls <= 17'b10010010000000010; // LW
        6'b101011: controls <= 17'b00010100000000010; // SW
        6'b000100: controls <= 17'b00001000001000010; // BEQ
        6'b001000: controls <= 17'b10010000000000010; // ADDI
        6'b001101: controls <= 17'b10110000011000010; // ORI
        6'b000010: controls <= 17'b00000001000000010; // J
        6'b000101: controls <= 17'b00001000001100010;  // BNQ
        6'b100001: controls <= 17'b10010010000010010; // LH
        6'b100000: controls <= 17'b10010010000011010; // LB
        6'b100100: controls <= 17'b10010000000000110; // lbu
        6'b001100: controls <= 17'b10110000100000000; //andi
        6'b000011: controls <= 17'b10000001000000001; //jal
        default:   controls <= 17'bxxxxxxxxxxxxxxxxx; // illegal op

    endcase
endmodule