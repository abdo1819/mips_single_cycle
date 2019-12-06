module multi(
		     input clk,
			 output logic [31:0] op,  //O/P
			 input logic [31:0] a,
			 input logic [31:0] b,
			 output logic finish
			 );

logic [22:0]Ofraction_HI; 
logic [22:0]Ofraction_LO;	//the least 23 bit will be ignored 
logic Osign;
logic [7:0]Opower;
logic [22:0]Afraction ;
logic [22:0]Bfraction ;
logic [7:0] Apower;
logic [7:0] Bpower;
logic Asign;
logic Bsign;


logic ones_Apower;
logic zeros_Apower;
logic zeros_Afraction;
logic ones_Bpower;
logic zeros_Bpower;
logic zeros_Bfraction;


logic carryExp;
logic [1:0] carryFra;

logic [2:0] roundbits;

logic [31:0] nan = 32'b01111111110000000000000000000000 ;
logic [31:0] nan_ = 32'b11111111110000000000000000000000 ;

logic [30:0] zero= 31'b0000000000000000000000000000000 ; //logic [31:0] zero= '0 ;

	always @(posedge clk)
	begin
		finish = 0;
	end
	
	always@(negedge clk)
	begin
	finish = 1;
	end

always @(a or b) begin
	
	{Asign,Apower,Afraction} = a;
	{Bsign,Bpower,Bfraction} = b;	

	ones_Apower = &Apower;
	zeros_Apower = ~|Apower;
	zeros_Afraction = ~|Afraction;

	ones_Bpower = &Bpower;
	zeros_Bpower = ~|Bpower;
	zeros_Bfraction = ~|Bfraction;


	Osign = Asign ^ Bsign;

	//special cases:
	// nan or nan => nan
	// inf and 0  => nan
	// inf and other => inf
	// 0   and other  => 0

	
	if ((ones_Apower && ~zeros_Afraction) || (ones_Bpower && ~zeros_Bfraction)) 
	// if a or b is nan (255,not zero) => nan
		op = nan;

	else if ((ones_Apower && zeros_Afraction)) // a is inf or _inf (255,zeros)
		begin
			if ((zeros_Bpower && zeros_Bfraction)) // b is 0 (0,0)
				op = nan_; // inf and 0 => nan
			else
			begin
				op[31]=Asign ^ Bsign;
				op[30:0] = {Apower,Afraction};  // inf/_inf and otherthings => inf/_inf
			end

		end

	else if ((ones_Bpower && zeros_Bfraction)) // b is inf (255,zeros)
		begin
			if ((zeros_Apower && zeros_Afraction)) // a is 0
				op = nan_; // inf and 0 => nan
			else
			begin
				op[31]=Asign ^ Bsign;			
				op[30:0] = {Apower,Afraction}; // inf/_inf and otherthings => inf/_inf
			end
		end
	
	else if ((zeros_Apower && zeros_Afraction)||(zeros_Bpower && zeros_Bfraction))
		// if a or b is zeros (0,0)
		begin	
		op[30:0] = zero;
		op[31]=Asign ^ Bsign;
		end
	else
		begin
		// clac fraction (1+f1)(1+f2)=(1+f1*f2+f1+f2) 
		{carryFra,Ofraction_HI,Ofraction_LO} = {1'b1,Afraction}*{1'b1,Bfraction} ;
		// exponent is biased by 127 so (000000011)
		//               represented in (100000010)
		{carryExp,Opower} = (Apower - 8'd127) + Bpower  ;
			
		
		// normlizing number in case of ofraction >
		if (carryFra[1])
			begin
			// $display("fraction normlized and a = %h",a); 

			{carryExp,Opower} = Opower + 8'b1; 
			Ofraction_LO = Ofraction_LO>>1;
			Ofraction_LO[22] = Ofraction_HI[0] ;
			
			Ofraction_HI = Ofraction_HI>>1;
			Ofraction_HI[22] = carryFra[0];
		end
		
		// rounding 
		if (Ofraction_LO[22])
		begin
			// $display("rounded and a = %h",a); 
			if (Ofraction_LO[22:20] == 3'b100)
			begin
				if (Ofraction_HI[0] == 1'b1)
					Ofraction_HI =Ofraction_HI+1'b1;
			end
			else
				Ofraction_HI =Ofraction_HI+1'b1;
		end
		// Ofraction_HI =Ofraction_HI+1'b1;
		
			//check the exponent
		//if overflow occurs, return inf
		//SOMETHING DOESN'T SEAM TO BE RIGHT HERE CHECK THIS LATER
		if (carryExp)
			begin	
			$display("overflow"); 
			Opower = 8'b11111111;
			Ofraction_HI = 23'b0;
			end

		op = {Osign , Opower , Ofraction_HI};
	end
	
	end
endmodule
