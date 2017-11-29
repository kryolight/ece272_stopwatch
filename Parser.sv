module parser (
	input logic [12:0] seconds,

	output logic [3:0] digit1_o,
	output logic [3:0] digit2_o,
	output logic [3:0] digit3_o,
	output logic [3:0] digit4_o
		);
		
//parses seconds into minutes and seconds
		assign digit1_o = (seconds / 600) % 10; 
		assign digit2_o = (seconds / 60) % 10; //minutes
		assign digit3_o = ((seconds % 60) / 10) % 10;
		assign digit4_o = (seconds % 60) % 10; //seconds

endmodule