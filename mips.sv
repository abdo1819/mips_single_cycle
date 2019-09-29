module mips(input logic clk, reset,
            output logic [31:0] pc,
            input logic [31:0] instr,
            output logic memwrite,
            output logic [31:0] aluout, writedata,
            input logic [31:0] readdata);

logic memtoreg, ne, regdst,
    regwrite, jump, pcsrc, zero;

logic [1:0] alusrc;

logic [2:0] alucontrol;

controller c(instr[31:26], instr[5:0], zero,
            memtoreg, memwrite, pcsrc,
            alusrc, regdst, regwrite, jump,ne,
            alucontrol);

datapath dp(clk, reset, memtoreg, pcsrc,
            alusrc, ne, regdst, regwrite, jump,
            alucontrol,
            zero, pc, instr,
            aluout, writedata, readdata);

endmodule