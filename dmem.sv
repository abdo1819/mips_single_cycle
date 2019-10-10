
module dmem(input logic clk, [1:0]we, //where we is an output of the control unit
            input logic [31:0] a, wd, 
            output logic [31:0] rd);

logic [31:0] RAM[63:0];

assign rd = RAM[a[31:2]]; // word aligned

always_ff @(posedge clk)
    
if ( we == 2'b01 ) begin
    RAM[a[31:2]] <= wd;
end 
else if ( we == 2'b10 ) begin //sh
    // {a[1],4'b0000} uses the second LSB as an indeicator to the upper 
    // or lower word starting point
    // which is an intuitive approuch to reach the half word
    RAM[a[31:2]][ {a[1],4'b0000} +: 16] <= wd[15:0]; // sh
end
else if (we == 2'b11) begin //sb
    // {a[1:0],3'b000} uses the first and second LSB as an indeicator to the  
    // specified byte starting point
    // which is an intuitive approuch to reach the byte
    RAM[a[31:2]][ {a[1:0],3'b000} +: 8] <= wd[7:0]; 
end

endmodule