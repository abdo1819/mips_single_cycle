module alu(input logic [31:0] a,b,
            input logic [4:0] shamt,
            input logic [3:0] f,
            output logic [31:0] y,
            output logic  zero);


always_comb
        case(f)
        4'b0000: y=a&b;
        4'b0001: y=a|b;
        4'b0010: y=a+b;
        4'b0011: y=0;
        4'b0100: y=a+(~b);
        4'b0101: y=a|(~b);
        4'b0110: y=a-b;
        4'b0111:
        begin
                y=a-b;
                y=y[31]?'b1:'b0;
        end
        4'b1000: y=(b>>shamt); //srl
        4'b1001: y=(b>>>shamt);//srA

        default: y=0;
        endcase


        assign zero =~(|y);


endmodule