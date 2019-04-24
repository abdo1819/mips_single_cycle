module alu(input logic [31:0] a,b,
            input logic [2:0] f,
            output logic [31:0] y,
            output logic  zero);


always_comb
        case(f)
        3'b000: y=a&b;
        3'b001: y=a|b;
        3'b010: y=a+b;
        3'b011: y=0;
        3'b100: y=a+(~b);
        3'b101: y=a|(~b);
        3'b110: y=a-b;
        3'b111:
        begin
                y=a-b;
                y=y[31]?'b1:'b0;
        end
        default: y=0;
        endcase


        assign zero =~(|y);


endmodule