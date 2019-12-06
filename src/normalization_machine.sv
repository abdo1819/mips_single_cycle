/**
 * Normalization machine
 *                                  _________
 *      (24-bit)fraction  ----------|         |---------- normalized rounded fraction (23-bit)
 *      (8-bit) exponent  ----------|_________|---------- normalized exponent (8-bit)
 *      (1-bit sign) ----------------------------s-------- (1-bit sign)
 *
 * @Author: Abdullah khaled (A-Siam) 
 */
module normalization_machine(
		input logic [23:0] fraction,
		input logic [7:0] exponent,
		output logic [22:0] n_fraction,
		output logic [7:0] n_exponenet,
		output logic overflow,
		output logic underflow,
		output logic done
	);
logic carry;
integer i = 0;
	always @(fraction,exponent) begin
	if (fraction[23] != 0) begin
		// rounding algorithm w/ example
		// we know that 1101 has 2 rounding possabilites 111 or 110 to fit in 3bit representation 
		// sub 1101-111 was greater than 1101-110
		//then 110 should be selected
		//else do the opesite procedural 
		n_fraction = fraction>>1;
		/*if ((fraction - n_fraction) > (fraction - {n_fraction[22:1],~n_fraction[0]})) begin
				n_fraction = {n_fraction[22:1],~n_fraction[0]};
			end*/
			if (fraction[0]==1) begin
				if (fraction[1]==0) begin
					n_fraction[0] = 0;
				end
			end
			{carry,n_exponenet} = exponent+1;
				overflow = carry;
	end
	else begin
	//scanning the valid bits only
	while(fraction[22-i]==0)begin
		i++;
	end
			n_fraction = fraction<<i;

		{carry,n_exponenet} = exponent+i;
		if (carry == 1) begin
			underflow = 1;
		end
	end
    done =1 ;
end
	
endmodule