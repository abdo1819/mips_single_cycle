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
        4'b0011: y=(b<<shamt);//sll
        4'b0100: y=a+(~b);
        4'b0101: y=a|(~b);
        4'b0110: y=a-b;
        
        4'b0111: //slt
        begin
                y=a-b;
                y=y[31]?'b1:'b0;
        end
        4'b1000: y = (b<<16); //lui
        4'b1001: y = a^b ; //xor  
        4'b1010: begin     //blez
                if(a<=0)
                        y=0 ;
                else
                        y=1;
                end
	              	  
        4'b1011: y = ( a >> (b[4:0]) ); //srlv
        4'b1100: y=(b>>shamt);
        default: y=0;
        endcase


        assign zero =~(|y);


endmodule