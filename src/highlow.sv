module highlow (input logic clk,
           input logic we,
           input logic ra,
           input logic [63:0] wd,
           output logic [31:0] rd);

logic [63:0] highlow;

always_ff @(posedge clk)
    if (we) highlow <= wd;

      assign rd = (ra)? highlow[31:0] : highlow[63:32];

endmodule