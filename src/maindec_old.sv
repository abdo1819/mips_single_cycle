module maindec__old(input logic [5:0] op,funct,
    output logic memtoreg, [1:0]memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,jr,
    output logic ne,
    output logic [1:0]half,
    output logic b,
    output logic [3:0] aluop,
    output logic lbu, link, spregwrite);


logic [20:0] controls;


assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link, spregwrite} = controls;


always_comb
// TODO fix mult ,jr, jal
    if((op == 0) && (funct==6'b001000)) begin
       controls <= 20'b01000000010000000000; // jr
    end
    else if ((op == 0) && (funct==6'b001001)) begin
       controls <= 18'b110000001000000001;  //jalr
    end
    else if ((op == 0) && (funct==6'b011000)) begin
        controls <= 21'b00000000011110000001; //mult;
    end

else
begin
    case(op)
        6'b000000: controls <= 21'b110000000011110000000; // RTYPE
        6'b100011: controls <= 21'b100100010000000000000; // LW
        6'b101011: controls <= 21'b000100100000000000000; // SW
        6'b000100: controls <= 21'b000010000000010000000; // BEQ
        6'b001000: controls <= 21'b100100000000000000000; // ADDI
        6'b001001: controls <= 21'b100100000000000000000; // ADDIU
        6'b001101: controls <= 21'b101100000000110000000; // ORI
        6'b000010: controls <= 21'b000000001000000000000; // J        
        6'b000101: controls <= 21'b000010000000011000000;  // BNQ
        6'b100001: controls <= 21'b100100010000000010000; // LH
        6'b100000: controls <= 21'b100100010000000011000; // LB
        6'b100100: controls <= 21'b100100000000000000100; // lbu
        6'b001100: controls <= 21'b101100000001110000000; //andi
        6'b000011: controls <= 21'b100000001000000000010; //jal
        6'b001111: controls <= 21'b100100000001000000000; // LUI
        6'b001110: controls <= 21'b100100000001010000000; // XORI
        6'b000110: controls <= 21'b000010000000100000000; // Blez	     	
        6'b001010: controls <= 21'b100100000001100000000; //slti
        6'b001011: controls <= 21'b100100000010000000000; //sltiu
        6'b000111: controls <= 21'b000010000011100000000; //bgtz
        6'b100101: controls <= 21'b100100010000000100000; //lhu
        6'b101001: controls <= 21'b000101000000000000000; // sh
        6'b101000: controls <= 21'b000101100000000000000; // sb

        default:   controls <= 21'bxxxxxxxxxxxxxxxxxxx; // illegal op

    endcase
    end
endmodule