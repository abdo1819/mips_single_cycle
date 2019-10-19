module controller(input logic [5:0] op, funct,
                    input logic zero,
                    output logic memtoreg, [1:0] memwrite,
                    output logic pcsrc, 
                    output logic [1:0] alusrc,
                    output logic regdst, regwrite,
                    output logic jump,jr,
                    output logic ne,
                    output logic [1:0]half,
                    output logic b,
                    output logic [4:0] alucontrol,
<<<<<<< HEAD
                    output logic lbu, link, spregwrite,
					
					// fpu
                    output logic [3:0] fpucontrol,
                    output logic mem_write_slct,
                    output logic fp_regwrite,
					output logic mem_to_fp,fp_regdst);
=======
                    output logic lbu, link, spregwrite, mf, resmove, spaddr);
>>>>>>> df4f7eb36bd47aac75aecde3e105b556b847a95e

logic [3:0] aluop;
logic branch;

maindec md(op,funct, memtoreg, memwrite, branch,
<<<<<<< HEAD
             alusrc, regdst, regwrite, jump,jr,ne, half, b, aluop, lbu, link, spregwrite,fpucontrol,mem_write_slct,fp_regwrite,mem_to_fp,fp_regdst);
			 
=======
             alusrc, regdst, regwrite, jump,jr,ne, half, b, aluop, lbu, link, spregwrite, mf, resmove, spaddr);
>>>>>>> df4f7eb36bd47aac75aecde3e105b556b847a95e
aludec ad(funct, aluop, alucontrol);



logic  bne_rc;
assign bne_rc = ne ^ zero ;
assign pcsrc = branch & bne_rc;

endmodule