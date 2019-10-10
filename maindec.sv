module maindec(input logic [5:0] op,funct,
    output logic memtoreg, [1:0]memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,jr,
    output logic ne,
    output logic half,
    output logic b,
    output logic [3:0] aluop,
    output logic lbu, link);

logic [18:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link} = controls;


always_comb
if((op == 0) && (funct==6'b001000)) begin
       controls <= 19'b0100000001000000000; // jr
     end
else
begin
    case(op)
        6'b000000: controls <= 19'b1100000000111100000; // RTYPE
        6'b100011: controls <= 19'b1001000100000000000; // LW
        6'b101011: controls <= 19'b0001001000000000000; // SW
        6'b000100: controls <= 19'b0000100000000100000; // BEQ
        6'b001000: controls <= 19'b1001000000000000000; // ADDI
        6'b001101: controls <= 19'b1011000000001100000; // ORI
        6'b000010: controls <= 19'b0000000010000000000; // J        
        6'b000101: controls <= 19'b0000100000000110000;  // BNQ
        6'b100001: controls <= 19'b1001000100000001000; // LH
        6'b100000: controls <= 19'b1001000100000001100; // LB
        6'b100100: controls <= 19'b1001000000000000010; // lbu
        6'b001100: controls <= 19'b1011000000011100000; //andi
        6'b000011: controls <= 19'b1000000010000000001; //jal
        6'b001111: controls <= 19'b1001000000010000000; // LUI
        6'b001110: controls <= 19'b1001000000010100000; // XORI
        6'b000110: controls <= 19'b0000100000001000000; // Blez	     	
        6'b001010: controls <= 19'b1001000000011000000; //slti
        6'b101001: controls <= 19'b0001010000000000000; // sh
        6'b101000: controls <= 19'b0001011000000000000; // sb

        default:   controls <= 19'bxxxxxxxxxxxxxxxxxxx; // illegal op

    endcase
    end
endmodule