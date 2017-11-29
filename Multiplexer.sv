module multiplexer(
	input logic [2:0] state_i,
	input logic [3:0] digit1_i,
	input logic [3:0] digit2_i,
	input logic [3:0] digit3_i,
	input logic [3:0] digit4_i,

	output logic [3:0] current_digit_o
		);
		
		parameter S0 = 3'b000; //First digit
		parameter S1 = 3'b001; //Second digit
		parameter S2 = 3'b011; //Third digit
		parameter S3 = 3'b100; //Fourth digit
		
		always_ff @ (state_i) //use case and run function based on state
			begin
				case(state_i)
					S0: current_digit_o = digit4_i;
					S1: current_digit_o = digit3_i;
					S2: current_digit_o = digit2_i;
					S3: current_digit_o = digit1_i;
					
					default: current_digit_o = digit1_i;
				endcase
			end
endmodule
	