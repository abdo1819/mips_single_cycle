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
    output logic lbu, link, spregwrite);

logic [18:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link, spregwrite} = controls;


always_comb
if((op == 0) && (funct==6'b001000)) begin
       controls <= 20'b0100000001000000000; // jr
     end
    else if ((op == 0) && (funct==6'b011000 )) begin
        controls <= 20'b0000000001111000001; //mult
    end
else
begin
    case(op)
        6'b000000: controls <= 20'b11000000001111000000; // RTYPE
        6'b100011: controls <= 20'b10010001000000000000; // LW
        6'b101011: controls <= 20'b00010010000000000000; // SW
        6'b000100: controls <= 20'b00001000000001000000; // BEQ
        6'b001000: controls <= 20'b10010000000000000000; // ADDI
        6'b001101: controls <= 20'b10110000000011000000; // ORI
        6'b000010: controls <= 20'b00000000100000000000; // J        
        6'b000101: controls <= 20'b00001000000001100000;  // BNQ
        6'b100001: controls <= 20'b10010001000000010000; // LH
        6'b100000: controls <= 20'b10010001000000011000; // LB
        6'b100100: controls <= 20'b10010000000000000100; // lbu
        6'b001100: controls <= 20'b10110000000111000000; //andi
        6'b000011: controls <= 20'b10000000100000000010; //jal
        6'b001111: controls <= 20'b10010000000100000000; // LUI
        6'b001110: controls <= 20'b10010000000101000000; // XORI
        6'b000110: controls <= 20'b00001000000010000000; // Blez	     	
        6'b001010: controls <= 20'b10010000000110000000; //slti
        6'b101001: controls <= 20'b00010100000000000000; // sh
        6'b101000: controls <= 20'b00010110000000000000; // sb

        default:   controls <= 20'bxxxxxxxxxxxxxxxxxxxx; // illegal op

    endcase
    end
endmodule
