module controller(input logic [5:0] op, funct,
                    input logic zero,
                    output logic memtoreg, memwrite,
                    output logic pcsrc, 
                    output logic [1:0] alusrc,
                    output logic regdst, regwrite,
                    output logic jump,
                    output logic ne,
                    output logic half,
                    output logic b,
                    output logic [3:0] alucontrol,
                    output logic jr,lbu, oneZero);

logic [2:0] aluop;
logic branch;

maindec md(op, memtoreg, memwrite, branch,
            alusrc, regdst, regwrite, jump,ne, half, b, aluop ,lbu, oneZero);

aludec ad(funct, aluop, alucontrol,jr);

logic  bne_rc;
assign bne_rc = ne ^ zero ;
assign pcsrc = branch & bne_rc;

endmodule