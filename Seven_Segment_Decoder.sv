module seven_segment_decoder(
	input logic [2:0] state_i,
	input logic [3:0] current_digit_i,

	output logic [6:0] segment_o
		);
		
		parameter zero_i = 4'b0000;
		parameter one_i = 4'b0001;
		parameter two_i = 4'b0010;
		parameter three_i = 4'b0011;
		parameter four_i = 4'b0100;
		parameter five_i = 4'b0101;
		parameter six_i = 4'b0110;
		parameter seven_i = 4'b0111;
		parameter eight_i = 4'b1000;
		parameter nine_i = 4'b1001;
		parameter A_i = 4'b1010;
		parameter B_i = 4'b1011;
		parameter C_i = 4'b1100;
		parameter D_i = 4'b1101;
		parameter E_i = 4'b1110;
		parameter F_i = 4'b1111;
		
		parameter zero_o = 7'b0000001;
		parameter one_o = 7'b1001111;
		parameter two_o = 7'b0010010;
		parameter three_o = 7'b0000110;
		parameter four_o = 7'b1001100;
		parameter five_o = 7'b0100100;
		parameter six_o = 7'b0100000;
		parameter seven_o = 7'b0001111;
		parameter eight_o = 7'b0000000;
		parameter nine_o = 7'b0001100;
		parameter A_o = 7'b0001000;
		parameter B_o = 7'b1100000;
		parameter C_o = 7'b0110001;
		parameter D_o = 7'b1000010;
		parameter E_o = 7'b0110000;
		parameter F_o = 7'b0111000;
		
		parameter blank = 7'b0000000;
		
		//decodes 4 bit number into 7 bits for 7 seg display
		always_ff @ (state_i)
			begin
				case(current_digit_i)
					zero_i: segment_o = zero_o;
					one_i: segment_o = one_o;
					two_i: segment_o = two_o;
					three_i: segment_o = three_o;
					four_i: segment_o = four_o;
					five_i: segment_o = five_o;
					six_i: segment_o = six_o;
					seven_i: segment_o = seven_o;
					eight_i: segment_o = eight_o;
					nine_i: segment_o = nine_o;
					A_i: segment_o = A_o;
					B_i: segment_o = B_o;
					C_i: segment_o = C_o;
					D_i: segment_o = D_o;
					E_i: segment_o = E_o;
					F_i: segment_o = F_o;
					
					default segment_o = blank;
				endcase
			end
endmodule