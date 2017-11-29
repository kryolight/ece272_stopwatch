module LED_top_module( 
	/**************************/
	/* Set inputs and outputs */
	/* to the whole FPGA here */
	/**************************/
	input logic reset_n, //be sure to set this input to PullUp, or connect the pin to 3.3V
	input logic go,
	
	output logic [6:0] segments_o,
	output logic [2:0] state
	//output logic state_timer
	//output logic [12:0] seconds
	);
		/*******************************/
		/* Set internal variables here */
		/*******************************/
		logic clk;		//used for the oscillator's 2.08 MHz clock
		logic clk_slow;	//used for slowed down, 5 Hz clock
		logic tick;

		logic state_timer;

		logic [12:0] seconds;

		logic [3:0] digit1;
		logic [3:0] digit2;
		logic [3:0] digit3;
		logic [3:0] digit4;
		logic [3:0] current_digit;
		
		/***********************/
		/* Define modules here */
		/***********************/
		//This is an instance of a special, built in module that accesses our chip's oscillator
		OSCH #("2.08") osc_int (	//"2.08" specifies the operating frequency, 2.08 MHz.
									//Other clock frequencies can be found in the MachX02's documentation
			.STDBY(1'b0),			//Specifies active state
			.OSC(clk),				//Outputs clock signal to 'clk' net
			.SEDSTDBY());			//Leaves SEDSTDBY pin unconnected
		
		
		//This module is instantiated from another file, 'Clock_Counter.sv'
		//It will take an input clock, slow it down based on parameters set inside of the module, and
		//output the new clock. Reset functionality is also built-in
		clock_counter counter_ssd(
			.clk_i(clk),
			.reset_n(reset_n),
			.clk_o(clk_slow));
			
		//This module is instantiated from another file, 'State_Machine.sv'
		//It contains a Moore state machine that will take a clock and reset, and output a state
		state_machine FSM_1(
			.clk_i(clk_slow),
			.reset_n(reset_n),
			.state_o(state));
			
		parser parser_1(
			.seconds(seconds),
			.digit1_o(digit1),
			.digit2_o(digit2),
			.digit3_o(digit3),
			.digit4_o(digit4));
		
		multiplexer mux_1(
			.state_i(state),
			.digit1_i(digit1),
			.digit2_i(digit2),
			.digit3_i(digit3),
			.digit4_i(digit4),
			.current_digit_o(current_digit));
		
		seven_segment_decoder decoder_1(
			.state_i(state),
			.current_digit_i(current_digit),
			.segment_o(segments_o));

		second_counter counter_sec(
			.clk(clk),
			.reset_n(reset_n),
			.tick(tick));

		seconds_tracker tracker(
			.tick(tick),
			.state_timer(state_timer),
			.reset_n  (reset_n),
			.seconds_o(seconds));

		//seconds_bounds bounds(
		// 	.seconds_i(seconds_1),
		// 	.seconds_o(seconds_2),
		// 	.overflow (overflow));

		timer_state_machine fsm_timer(
			.reset_n    (reset_n),
			.go         (go),
			//.stop       (stop),
			//.overflow   (overflow),
			.state_timer(state_timer));
		
		/************************************************/
		/* Add modules for:								*/
		/* Parser 		Determines the 1000's, 100's,   */
		/*				10's and 1's place of the number*/
		/* Multiplexer	Determines which parser output  */
		/*				to pass to the decoder			*/
		/* Decoder		Convert 4-bit binary to 7-seg   */
		/*				output for numbers 0-9			*/
		/************************************************/
endmodule
