module second_counter(
	input logic clk, reset_n,

	output logic tick
	);

	logic [20:0] counter;

	//takes in a 2.08 MHz clock and turns it into a 1Hz clock.

	always_ff @ (posedge clk, negedge reset_n)
		begin
			counter <= counter + 1;
			if(!reset_n)
			begin 
				tick <= 0;
				counter <= 0;
			end
			else
				if(counter >= 1040000)
				begin
					tick <= ~tick;
					counter <= 0;
				end
		end
endmodule