module maindec(input logic [5:0] op,funct,
    output logic memtoreg, memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,jr,
    output logic ne,
    output logic half,
    output logic b,
    output logic [2:0] aluop,
    output logic lbu, link);

logic [16:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link} = controls;


always_comb
if((op == 0) && (funct==6'b001000)) begin
       controls <= 17'b01000000100000000; // jr
     end
else
begin
    case(op)
        6'b000000: controls <= 17'b11000000001000000; // RTYPE
        6'b100011: controls <= 17'b10010010000000000; // LW
        6'b101011: controls <= 17'b00010100000000000; // SW
        6'b000100: controls <= 17'b00001000000100000; // BEQ
        6'b001000: controls <= 17'b10010000000000000; // ADDI
        6'b001101: controls <= 17'b10110000001100000; // ORI
        6'b000010: controls <= 17'b00000001000000000; // J        
        6'b000101: controls <= 17'b00001000000110000;  // BNQ
        6'b100001: controls <= 17'b10010010000001000; // LH
        6'b100000: controls <= 17'b10010010000001100; // LB
        6'b100100: controls <= 17'b10010000000000010; // lbu
        6'b001100: controls <= 17'b10110000010000000; //andi
        6'b000011: controls <= 17'b10000001000000001; //jal
        6'b001111: controls <= 17'b10010000010000000; // LUI
        6'b001110: controls <= 17'b10010000010100000; // XORI
        6'b000110: controls <= 17'b00001000001000000; // Blez	     	
        6'b001010: controls <= 17'b10010000011000000; //slti

        default:   controls <= 17'bxxxxxxxxxxxxxxxxx; // illegal op

    endcase
    end
endmodule