/*
*Author: Mahmoud Hassan 
**/
/*
I used her Non-restoring division algorithm

 it calculates the remainder by
successively subtracting the shifted divisor from the
dividend until the remainder is in the appropriate range

  non-restoring divide is used to avoid timing issues that can occur in restore divide
but The area requirement of nonrestoring divide is larger than the restoring divide because non-restoring divide
algorithm requires an adder and a subtractor, which adds more hardware.



*/

module divufile (dividend,divisor,Q,R,finish);

logic clk;  // clock
//input EN;  // clock
input [31:0] dividend;
input [31:0] divisor;

output [31:0] Q; // quotient
output [31:0] R; //remainder 
output finish;

reg [31:0] Q;
reg [63:0] dividend_copy,divisor_copy,diff;
 
wire [31:0] R = dividend_copy[31:0];

reg [31:0] nb1; //numper of bits it used  as count

wire finish=!nb1;
always
    begin
    clk <= 1; # 1; clk <= 0; # 1;
    end
  always @(dividend,divisor) 
begin
  nb1=32; 
	 Q=0; // initialize quotient by zero 	;  
	  dividend_copy={32'd0,dividend}; // initialize dividend in lower 32 sb  
	  divisor_copy = {1'd0,divisor,31'd0};// initialize divisor in upper 32 sb but before 1'st subtraction we have SR it one bit 
end
always @(posedge clk)	    
   begin
   if (!finish)
    begin
		 diff =dividend_copy-divisor_copy;
		 Q= Q<<1 ; //shift left
		   if (!diff[63]) //if diff >0
			 begin
			 dividend_copy=diff;
			 Q[0]=1'd1; //put lsb =1
			 end 
	 
	  divisor_copy=divisor_copy >> 1;
	  nb1=nb1-1; //break loop when nb =0  
   end
end
endmodule


