module seconds_bounds (
	input logic [12:0] seconds_i,    // Clock
	
	output logic overflow,
	output logic [12:0] seconds_o
);

always_comb
	begin
		if(seconds_i >= 6039)
			begin
				seconds_o = 6039;
				overflow = 1;
			end
		else
			begin
				seconds_o = seconds_i;
				overflow = 0;
			end
	end
endmodule