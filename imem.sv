module imem(input logic [5:0] a,
            output logic [31:0] rd);

logic [31:0] RAM[63:0];

initial

<<<<<<< HEAD
    $readmemh("F001.dat", RAM);
=======
    $readmemh("memfile.dat", RAM);
>>>>>>> df4f7eb36bd47aac75aecde3e105b556b847a95e
    assign rd = RAM[a]; // word aligned

endmodule