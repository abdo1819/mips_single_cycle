module maindec(input logic [5:0] op,funct,
    output logic memtoreg, [1:0]memwrite,
    output logic branch, 
    output logic [1:0] alusrc,
    output logic regdst, regwrite,
    output logic jump,jr,
    output logic ne,
    output logic [1:0]half,
    output logic b,
    output logic [3:0] aluop,
    output logic lbu, link, spregwrite, mf, resmove, spaddr);


    logic [21:0] controls;

    assign resmove = funct[3];
    assign spaddr = funct[1];

assign {regwrite, regdst, alusrc, branch, memwrite,
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link, spregwrite,mf} = controls;


always_comb

    case(op)
        6'b000000: 
        begin
            // RTYPE
            controls[21] <= ~(funct[4] | funct[3] & ~funct[5]); //regwrite
            controls[20:13] <= 8'b10000000;                     //regdst to jump
            controls[12] <= ~funct[5] & ~funct[4] & funct[3] & ~funct[2] & ~funct[1]; //jr
            controls[11:3] <= 9'b111100000;                    //aluop to lbu
            controls[2] <= ~funct[5] & ~funct[4] & funct[3] & ~funct[2] & ~funct[1] & funct[0]; //link
            controls[1] <= ~funct[5] & funct[4] & ~funct[2] & funct[0] | ~funct[5] & funct[4] & funct[3] & ~funct[2]; //spregwrite
            controls[0] <= ~funct[5] & funct[4] & ~funct[3] & ~funct[2] & ~funct[0]; //mf
        end
        6'b100011: controls <= 22'b1001000100000000000000; // LW
        6'b101011: controls <= 22'b0001001000000000000000; // SW
        6'b000100: controls <= 22'b0000100000000100000000; // BEQ
        6'b001000: controls <= 22'b1001000000000000000000; // ADDI
        6'b001001: controls <= 22'b1001000000000000000000; // ADDIU
        6'b001101: controls <= 22'b1011000000001100000000; // ORI
        6'b000010: controls <= 22'b0000000010000000000000; // J        
        6'b000101: controls <= 22'b0000100000000110000000;  // BNQ
        6'b100001: controls <= 22'b1001000100000000100000; // LH
        6'b100000: controls <= 22'b1001000100000000110000; // LB
        6'b100100: controls <= 22'b1001000000000000001000; // lbu
        6'b001100: controls <= 22'b1011000000011100000000; //andi
        6'b000011: controls <= 22'b1000000010000000000100; //jal
        6'b001111: controls <= 22'b1001000000010000000000; // LUI
        6'b001110: controls <= 22'b1001000000010100000000; // XORI
        6'b000110: controls <= 22'b0000100000001000000000; // Blez	     	
        6'b001010: controls <= 22'b1001000000011000000000; //slti
        6'b001011: controls <= 22'b1001000000100000000000; //sltiu
        6'b000111: controls <= 22'b0000100000111000000000; //bgtz
        6'b100101: controls <= 22'b1001000100000001000000; //lhu
        6'b101001: controls <= 22'b0001010000000000000000; // sh
        6'b101000: controls <= 22'b0001011000000000000000; // sb

        default:   controls <= 22'bxxxxxxxxxxxxxxxxxxxx; // illegal op

    endcase
    
endmodule
