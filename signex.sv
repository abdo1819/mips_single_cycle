//parameterized sign extenstion by abdullah khaled
module signex #(parameter extamount = 16,parameter inputsize = 16)
			   (input [inputsize-1:0]x,
			   output [inputsize+extamount-1:0]o);

assign o = {{extamount{x[inputsize-1]}},x};

endmodule