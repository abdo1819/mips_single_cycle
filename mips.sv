module mips(input logic clk, reset,
            output logic [31:0] pc,
            input logic [31:0] instr,
            output logic memwrite,
            output logic [31:0] aluout, writedata,
            input logic [31:0] readdata);

logic memtoreg, ne, regdst,
    regwrite, jump, pcsrc, zero, half, b, oneZero;

logic [1:0] alusrc;

logic [3:0] alucontrol;

controller c(instr[31:26], instr[5:0], zero,
            memtoreg, memwrite, pcsrc,
            alusrc, regdst, regwrite, jump, ne, half, b,
            alucontrol, jr,lbu, oneZero, link);

datapath dp(clk, reset, memtoreg, pcsrc,
            alusrc, ne, regdst, jr,lbu, link, regwrite, jump, half, b, oneZero,
            alucontrol, 
            zero, pc, instr,
            aluout, writedata, readdata);

endmodule