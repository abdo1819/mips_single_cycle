module extone(input logic [15:0] a,
                output logic [31:0] y);

logic one;
assign one = 1;
assign y = {{16{one}}, a};
endmodule