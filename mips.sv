
module mips(input logic clk, reset,
            output logic [31:0] pc,
            input logic [31:0] instr,
            output logic [1:0]memwrite,
            output logic [31:0] aluout, writedata,
            input logic [31:0] readdata
	                 
            );

logic memtoreg, ne, regdst,regwrite, jump,jr, pcsrc, zero, b, link, spregwrite,mf, resmove, spaddr; // controller output

 // fp
 logic [3:0] fpu_control;
 logic mem_write_slct,fpu_mem_write;
 logic fp_regwrite;
 logic mem_to_fp;
 

logic [1:0] alusrc, half;

logic [4:0] alucontrol;

controller c(instr[31:26], instr[5:0], zero,
            memtoreg, memwrite, pcsrc,
            alusrc, regdst, regwrite, jump,jr, ne, half, b,
             alucontrol,lbu, link, spregwrite, mf, resmove, spaddr,fpu_control,fpu_mem_write,fp_regwrite,mem_to_fp,fp_regdst);

datapath dp(clk, reset, memtoreg, pcsrc,
            alusrc, ne, regdst, lbu, link, regwrite, jump,jr, half,b, spregwrite, mf, resmove, spaddr,
            alucontrol,
            zero, pc, instr,
            aluout, writedata, readdata,fpu_control,fpu_mem_write,fp_regwrite,mem_to_fp,fp_regdst);

endmodule