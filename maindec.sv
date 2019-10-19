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
<<<<<<< HEAD
    output logic lbu, link, spregwrite,
	output logic [3:0] fpu_control,
	output logic fpu_mem_write,
	output logic fp_regwrite,
	output logic mem_to_fp,fp_regdst);


logic [28:0] controls;
=======
    output logic lbu, link, spregwrite, mf, resmove, spaddr);


    logic [21:0] controls;
>>>>>>> df4f7eb36bd47aac75aecde3e105b556b847a95e

    assign resmove = funct[3];
    assign spaddr = funct[1];

assign {regwrite, regdst, alusrc, branch, memwrite,
<<<<<<< HEAD
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link, spregwrite, fpu_control, fpu_mem_write 
                                                                    ,fp_regwrite ,mem_to_fp ,fp_regdst} = controls;


always_comb
if((op == 0) && (funct==6'b001000)) begin
       controls <= 29'b01000000010000000000000000; // jr
     end
     else if ((op == 0) && (funct==6'b001001)) begin
       controls <= 18'b110000001000000001;
     end
	 else if( op == 6'b010001 ) begin
		case(funct)
			6'b000000: controls <= 29'b00000000000000000000000000101; // fpu add
			6'b000001: controls <= 29'b00000000000000000000000010101; // fpu subtract 
			6'b000010: controls <= 29'b00000000000000000000000100101; // fpu multi
			6'b000001: controls <= 29'b00000000000000000000000110101; // fpu division
			//6'b110001: controls <= 29'b000100000000000000000xxxx0110; // fpu load word
			//6'b110001: controls <= 29'b000100100000000000000xxxx1000; // fpu save word
		endcase
	 end

else
begin
    case(op)
        6'b000000: controls <= 29'b11000000001111000000000000000; // RTYPE
        6'b100011: controls <= 29'b10010001000000000000000000000; // LW
        6'b101011: controls <= 29'b00010010000000000000000000000; // SW
        6'b000100: controls <= 29'b00001000000001000000000000000; // BEQ
        6'b001000: controls <= 29'b10010000000000000000000000000; // ADDI
        6'b001001: controls <= 29'b10010000000000000000000000000; // ADDIU
        6'b001101: controls <= 29'b10110000000011000000000000000; // ORI
        6'b000010: controls <= 29'b00000000100000000000000000000; // J        
        6'b000101: controls <= 29'b00001000000001100000000000000;  // BNQ
        6'b100001: controls <= 29'b10010001000000001000000000000; // LH
        6'b100000: controls <= 29'b10010001000000001100000000000; // LB
        6'b100100: controls <= 29'b10010000000000000010000000000; // lbu
        6'b001100: controls <= 29'b10110000000111000000000000000; //andi
        6'b000011: controls <= 29'b10000000100000000001000000000; //jal
        6'b001111: controls <= 29'b10010000000100000000000000000; // LUI
        6'b001110: controls <= 29'b10010000000101000000000000000; // XORI
        6'b000110: controls <= 29'b00001000000010000000000000000; // Blez	     	
        6'b001010: controls <= 29'b10010000000110000000000000000; //slti
        6'b001011: controls <= 29'b10010000001000000000000000000; //sltiu
        6'b000111: controls <= 29'b00001000001110000000000000000; //bgtz
        6'b100101: controls <= 29'b10010001000000010000000000000; //lhu
        6'b101001: controls <= 29'b00010100000000000000000000000; // sh
        6'b101000: controls <= 29'b00010110000000000000000000000; // sb
    			 6'b110001: controls <= 29'b00010000000000000000000000110; // fpu load word
			  6'b110001: controls <= 29'b00010010000000000000000001000; // fpu save word
		
					
		
        

        default:   controls <= 29'bxxxxxxxxxxxxxxxxxxx; // illegal op
=======
        memtoreg, jump,jr, aluop, ne, half, b, lbu, link, spregwrite,mf} = controls;


always_comb

    case(op)
        6'b000000: 
        begin
            // RTYPE
            controls[21] <= funct[5] | ~funct[4]&~funct[3] | ~funct[3]&~funct[0]; //regwrite
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
>>>>>>> df4f7eb36bd47aac75aecde3e105b556b847a95e

    endcase
    
endmodule
