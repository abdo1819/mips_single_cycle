module mux4 #(parameter WIDTH = 8)
            (input logic [WIDTH-1:0] d0,d1,d2,d3,
            input logic [1:0] s,
            output logic [WIDTH-1:0] Y);

    always_comb
        case ( s )
            2'b00: Y = d0;
            2'b01: Y = d1;
            2'b10: Y = d2;
            2'b11: Y = d3;
            default: Y = 16'hxxxx;
        endcase
endmodule
