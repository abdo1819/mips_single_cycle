module extnext_temp(input logic [4:0] a,
                output logic [31:0] y);

logic zero;
assign zero = 0;
assign y = {{27{zero}}, a};
endmodule