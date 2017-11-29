module seconds_tracker (
	input logic tick,    // Clock
	input logic reset_n,
	input logic state_timer,

	output logic [12:0] seconds_o
);
//keeps track of how many ticks have passed
always_ff @(posedge tick, negedge reset_n)
	begin
		//seconds_o <= seconds_o + 1;
		if(!reset_n)
			begin
				seconds_o <= 0;
			end
		else
			if(state_timer)
				begin
					seconds_o <= seconds_o + 1;
				end
	end

endmodule