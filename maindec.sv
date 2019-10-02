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
    output logic lbu, oneZero);

logic [15:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump, aluop, ne, half, b, lbu, oneZero} = controls;


always_comb
    case(op)
        6'b000000: controls <= 16'b1100000001000001; // RTYPE
        6'b100011: controls <= 16'b1001001000000001; // LW
        6'b101011: controls <= 16'b0001010000000001; // SW
        6'b000100: controls <= 16'b0000100000100001; // BEQ
        6'b001000: controls <= 16'b1001000000000001; // ADDI
        6'b001101: controls <= 16'b1011000001100001; // ORI
        6'b000010: controls <= 16'b0000000100000001; // J
        6'b000101: controls <= 16'b0000100000110001;  // BNQ
        6'b100001: controls <= 16'b1001001000001001; // LH
        6'b100000: controls <= 16'b1001001000001101; // LB
        6'b100100: controls <= 16'b1001000000000011; // lbu
        6'b001100: controls <= 16'b1011000010000000; //andi
        default:   controls <= 16'bxxxxxxxxxxxxxxxx; // illegal op

    endcase
endmodule