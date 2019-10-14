module maindec(input logic [5:0] op,funct,
    output logic memtoreg, memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,jr,
    output logic ne,
    output logic [1:0]half,
    output logic b,
    output logic [3:0] aluop,
    output logic lbu, link);

logic [18:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link} = controls;


always_comb
if((op == 0) && (funct==6'b001000)) begin
       controls <= 18'b010000001000000000; // jr
     end
     else if ((op == 0) && (funct==6'b001001)) begin
       controls <= 18'b110000001000000001; // jalr
     end

else
begin
    case(op)
        6'b000000: controls <= 19'b1100000001111000000; // RTYPE
        6'b100011: controls <= 19'b1001001000000000000; // LW
        6'b101011: controls <= 19'b0001010000000000000; // SW
        6'b000100: controls <= 19'b0000100000001000000; // BEQ
        6'b001000: controls <= 19'b1001000000000000000; // ADDI
        6'b001101: controls <= 19'b1011000000011000000; // ORI
        6'b000010: controls <= 19'b0000000100000000000; // J        
        6'b000101: controls <= 19'b0000100000001100000;  // BNQ
        6'b100001: controls <= 19'b1001001000000001000; // LH
        6'b100000: controls <= 19'b1001001000000001100; // LB
        6'b100100: controls <= 19'b1001000000000000010; // lbu
        6'b001100: controls <= 19'b1011000000111000000; //andi
        6'b000011: controls <= 19'b1000000100000000001; //jal
        6'b001111: controls <= 19'b1001000000100000000; // LUI
        6'b001110: controls <= 19'b1001000000101000000; // XORI
        6'b000110: controls <= 19'b0000100000010000000; // Blez	     	
        6'b001010: controls <= 19'b1001000000110000000; //slti
        6'b001011: controls <= 19'b1001000001000000000; //sltiu
        6'b000111: controls <= 19'b0000100001110000000; //bgtz
        6'b100101: controls <= 19'b1001001000000010000; //lhu

        default:   controls <= 19'bxxxxxxxxxxxxxxxxxxx; // illegal op

    endcase
    end
endmodule