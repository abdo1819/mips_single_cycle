module mips(input logic clk, reset,
            output logic [31:0] pc,
            input logic [31:0] instr,
            output logic memwrite,
            output logic [31:0] aluout, writedata,
            input logic [31:0] readdata);

logic memtoreg, ne, regdst,
    regwrite, jump,jr, pcsrc, zero, half, b, link;

logic [1:0] alusrc;

logic [3:0] alucontrol;

controller c(instr[31:26], instr[5:0], zero,
            memtoreg, memwrite, pcsrc,
            alusrc, regdst, regwrite, jump,jr, ne, half, b,
            alucontrol,lbu, link);

datapath dp(clk, reset, memtoreg, pcsrc,
            alusrc, ne, regdst, lbu, link, regwrite, jump,jr, half,b,
            alucontrol,
            zero, pc, instr,
            aluout, writedata, readdata);

endmodule