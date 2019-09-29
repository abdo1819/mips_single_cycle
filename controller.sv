module controller(input logic [5:0] op, funct,
                    input logic zero,
                    output logic memtoreg, memwrite,
                    output logic pcsrc, 
                    output logic [1:0] alusrc,
                    output logic regdst, regwrite,
                    output logic jump,
                    output logic ne,
                    output logic [2:0] alucontrol);

logic [1:0] aluop;
logic branch;

maindec md(op, memtoreg, memwrite, branch,
            alusrc, regdst, regwrite, jump,ne, aluop);

aludec ad(funct, aluop, alucontrol);

logic  bne_rc;
assign bne_rc = ne ^ zero ;
assign pcsrc = branch & bne_rc;

endmodule