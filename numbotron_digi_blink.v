/////////////////////////////////////////////////////////////////////////////
// ui display toggle
// turns on/off the digit line for the currently selected entry.

module UIDigiFlash( prog_running, digit, slow_clock, digits, digits_out );
input prog_running;
input [4:0] digit;
input [31:0] slow_clock;
input [31:0]  digits;
output [31:0] digits_out;

wire should_blink_on = slow_clock[0] || ( prog_running == 1 );
assign digits_out[ 0] = digit != 5'd0  ? digits[ 0] : should_blink_on & digits[ 0];
assign digits_out[ 1] = digit != 5'd1  ? digits[ 1] : should_blink_on & digits[ 1];
assign digits_out[ 2] = digit != 5'd2  ? digits[ 2] : should_blink_on & digits[ 2];
assign digits_out[ 3] = digit != 5'd3  ? digits[ 3] : should_blink_on & digits[ 3];
assign digits_out[ 4] = digit != 5'd4  ? digits[ 4] : should_blink_on & digits[ 4];
assign digits_out[ 5] = digit != 5'd5  ? digits[ 5] : should_blink_on & digits[ 5];
assign digits_out[ 6] = digit != 5'd6  ? digits[ 6] : should_blink_on & digits[ 6];
assign digits_out[ 7] = digit != 5'd7  ? digits[ 7] : should_blink_on & digits[ 7];
assign digits_out[ 8] = digit != 5'd8  ? digits[ 8] : should_blink_on & digits[ 8];
assign digits_out[ 9] = digit != 5'd9  ? digits[ 9] : should_blink_on & digits[ 9];
assign digits_out[10] = digit != 5'd10 ? digits[10] : should_blink_on & digits[10];
assign digits_out[11] = digit != 5'd11 ? digits[11] : should_blink_on & digits[11];
assign digits_out[12] = digit != 5'd12 ? digits[12] : should_blink_on & digits[12];
assign digits_out[13] = digit != 5'd13 ? digits[13] : should_blink_on & digits[13];
assign digits_out[14] = digit != 5'd14 ? digits[14] : should_blink_on & digits[14];
assign digits_out[15] = digit != 5'd15 ? digits[15] : should_blink_on & digits[15];
assign digits_out[16] = digit != 5'd16 ? digits[16] : should_blink_on & digits[16];
assign digits_out[17] = digit != 5'd17 ? digits[17] : should_blink_on & digits[17];
assign digits_out[18] = digit != 5'd18 ? digits[18] : should_blink_on & digits[18];
assign digits_out[19] = digit != 5'd19 ? digits[19] : should_blink_on & digits[19];
assign digits_out[20] = digit != 5'd20 ? digits[20] : should_blink_on & digits[20];
assign digits_out[21] = digit != 5'd21 ? digits[21] : should_blink_on & digits[21];
assign digits_out[22] = digit != 5'd22 ? digits[22] : should_blink_on & digits[22];
assign digits_out[23] = digit != 5'd23 ? digits[23] : should_blink_on & digits[23];
assign digits_out[24] = digit != 5'd24 ? digits[24] : should_blink_on & digits[24];
assign digits_out[25] = digit != 5'd25 ? digits[25] : should_blink_on & digits[25];
assign digits_out[26] = digit != 5'd26 ? digits[26] : should_blink_on & digits[26];
assign digits_out[27] = digit != 5'd27 ? digits[27] : should_blink_on & digits[27];
assign digits_out[28] = digit != 5'd28 ? digits[28] : should_blink_on & digits[28];
assign digits_out[29] = digit != 5'd29 ? digits[29] : should_blink_on & digits[29];
assign digits_out[30] = digit != 5'd30 ? digits[30] : should_blink_on & digits[30];
assign digits_out[31] = digit != 5'd31 ? digits[31] : should_blink_on & digits[31];


endmodule
