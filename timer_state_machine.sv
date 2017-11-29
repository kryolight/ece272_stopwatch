module timer_state_machine (
	input logic reset_n,    // Clock
	input logic go, // Clock Enable
	//input logic stop,  // Asynchronous reset active low
	//input logic overflow,

	output logic state_timer
);
	
// 0 = stop
// 1 = go

//toggles between 2 states when go input triggers
always_ff @ (posedge go, negedge reset_n)
	if(!reset_n)
		begin
			state_timer = 0;
		end
	else
		begin
			state_timer = ~state_timer;
		end
endmodule