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

module divfile (dividend,divisor,Q,R,finish);

logic clk;  // clock
//input EN;  // clock
input [31:0] dividend;
input [31:0] divisor;

output [31:0] Q; // quotient
output [31:0] R; //remainder 
output finish;

reg [31:0] Q;
reg [31:0] dividend;
reg [31:0] divisor;
reg [31:0] R,q;
reg [63:0] dividend_copy,divisor_copy,diff;
reg n; 
//wire [31:0] R = dividend_copy[31:0];


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
	 n=1;
	if((dividend[31]==1&&divisor[31]==0)||(dividend[31]==0&&divisor[31]==1)||(dividend[31]==1&&divisor[31]==1))
	    begin
	  	   if (dividend[31]==1&&divisor[31]==0)
           begin
		     R=0;
		     q=-1;
	         dividend_copy={32'd0,2147483648-dividend[30:0]};
	  	     divisor_copy = {1'd0,divisor,31'd0};
	       end
          if (dividend[31]==0&&divisor[31]==1)
	      begin
		  	 R=-1;
		     q=-1;
	         dividend_copy={32'd0,dividend};
             divisor_copy = {1'd0,2147483648-divisor[30:0],31'd0};
	       end
	       if (dividend[31]==1&&divisor[31]==1)
	      begin
		      R=0;
		      q=0;
	         dividend_copy={32'd0,2147483648-dividend[30:0]};
             divisor_copy = {1'd0,2147483648-divisor[30:0],31'd0};
	      end
	    end
	 if(dividend[31]==0&&divisor[31]==0)
	 begin
	 R=0;
	 q=0;
	 dividend_copy={32'd0,dividend}; // initialize dividend in lower 32 sb  
	 divisor_copy = {1'd0,divisor,31'd0};// initialize divisor in upper 32 sb but before 1'st subtraction we have SR it one bit
	 end
	  
//dividend_copy={32'd0,2147483648-dividend[30:0]}; // initialize dividend in lower 32 sb  
	//  divisor_copy = {1'd0,2147483648-divisor,31'd0};// initialize divisor in upper 32 sb but before 1'st subtraction we have SR it one bit 
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
   else
   if(n)
   begin
	if(q===-1)
    begin 
	 Q[30:0]=2147483648-Q[30:0];
	 Q[31]=1;
	end	
		   if(R===-1)
    begin 
	 R[31:0]=dividend-((Q-1)*divisor);
	end
	 else
	   	 R[31:0]=dividend-((Q)*divisor);
n=0;
end	
end
endmodule


