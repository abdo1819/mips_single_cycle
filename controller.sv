module controller(input logic [5:0] op, funct,
                    input logic zero,
                    output logic memtoreg, [1:0] memwrite,
                    output logic pcsrc, 
                    output logic [1:0] alusrc,
                    output logic regdst, regwrite,
                    output logic jump,jr,
                    output logic ne,
                    output logic half,
                    output logic b,
                    output logic [3:0] alucontrol,
                    output logic lbu, link);

logic [3:0] aluop;
logic branch;

maindec md(op,funct, memtoreg, memwrite, branch,
            alusrc, regdst, regwrite, jump,jr,ne, half, b, aluop, lbu, link);

aludec ad(funct, aluop, alucontrol);

logic  bne_rc;
assign bne_rc = ne ^ zero ;
assign pcsrc = branch & bne_rc;

endmodule