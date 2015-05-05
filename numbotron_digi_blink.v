/////////////////////////////////////////////////////////////////////////////
// ui display toggle
// turns on/off the digit line for the currently selected entry.

module UIDigiFlash( prog_running, digit, slow_clock, digit_in, digits_out );
input prog_running;
input [4:0] digit;
input [31:0] slow_clock;
input [4:0]  digit_in;
output [31:0] digits_out;

wire should_blink_on = slow_clock[0] || ( prog_running == 1 ) || digit_in != digit;
assign digits_out[ 0] = digit_in == 5'd0  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 1] = digit_in == 5'd1  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 2] = digit_in == 5'd2  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 3] = digit_in == 5'd3  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 4] = digit_in == 5'd4  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 5] = digit_in == 5'd5  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 6] = digit_in == 5'd6  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 7] = digit_in == 5'd7  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 8] = digit_in == 5'd8  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[ 9] = digit_in == 5'd9  && should_blink_on ? 1'b1 : 1'b0;

assign digits_out[10] = digit_in == 5'd10  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[11] = digit_in == 5'd11  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[12] = digit_in == 5'd12  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[13] = digit_in == 5'd13  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[14] = digit_in == 5'd14  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[15] = digit_in == 5'd15  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[16] = digit_in == 5'd16  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[17] = digit_in == 5'd17  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[18] = digit_in == 5'd18  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[19] = digit_in == 5'd19  && should_blink_on ? 1'b1 : 1'b0;

assign digits_out[20] = digit_in == 5'd20  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[21] = digit_in == 5'd21  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[22] = digit_in == 5'd22  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[23] = digit_in == 5'd23  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[24] = digit_in == 5'd24  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[25] = digit_in == 5'd25  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[26] = digit_in == 5'd26  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[27] = digit_in == 5'd27  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[28] = digit_in == 5'd28  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[29] = digit_in == 5'd29  && should_blink_on ? 1'b1 : 1'b0;

assign digits_out[30] = digit_in == 5'd30  && should_blink_on ? 1'b1 : 1'b0;
assign digits_out[31] = digit_in == 5'd31  && should_blink_on ? 1'b1 : 1'b0;

endmodule
