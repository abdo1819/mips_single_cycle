module spregfile(input logic clk,
                 input logic we4,//spregwrite enable
                 input logic [31:0] wdilo,input logic [31:0] wdihi,//regwrite data in lo and hi
                 output logic [31:0] rdflo,output logic [31:0] rdfhi);// read data from lo and hi

logic [31:0] lo;//special reg for restoting data in mult and div
logic [31:0] hi;//special reg for restoting data in mult and div

always_ff @(posedge clk)
    if (we4)
	   begin
	    lo <= wdilo;
		hi <= wdihi;
	   end
	   
	   assign rdflo = (lo != 0) ? lo : 0;
       assign rdfhi = (hi != 0) ? hi : 0;
 

endmodule