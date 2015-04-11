//////////////////////////////////////////////////////////
//
module EditRegs( clk, incDigit, incSelection, slow_clock, slow_count, digit, doInc );
input clk;
input incDigit;      // ui for changing which digit to edit.
input incSelection;  // ui for incrementing digit.
input slow_clock;    // 1 clk input
input [31:0] slow_count;
output [4:0] digit;
output [31:0]doInc;
reg [4:0] digit;

wire [31:0]doInc;
integer i;
always @(posedge clk )
if (slow_clock )
begin


  if( incDigit )
  begin
     if( digit == 5'd31 ) digit <= 0;
	  digit <= digit + 1;
  end
end
assign doInc[0] =  ( slow_clock & incSelection && (digit == 0) ) ? 1 : 0;
assign doInc[1] =  ( slow_clock & incSelection && (digit == 1) ) ? 1 : 0;
assign doInc[2] =  ( slow_clock & incSelection && (digit == 2) ) ? 1 : 0;
assign doInc[3] =  ( slow_clock & incSelection && (digit == 3) ) ? 1 : 0;
assign doInc[4] =  ( slow_clock & incSelection && (digit == 4) ) ? 1 : 0;
assign doInc[5] =  ( slow_clock & incSelection && (digit == 5) ) ? 1 : 0;
assign doInc[6] =  ( slow_clock & incSelection && (digit == 6) ) ? 1 : 0;
assign doInc[7] =  ( slow_clock & incSelection && (digit == 7) ) ? 1 : 0;
assign doInc[8] =  ( slow_clock & incSelection && (digit == 8) ) ? 1 : 0;
assign doInc[9] =  ( slow_clock & incSelection && (digit == 9) ) ? 1 : 0;
assign doInc[10] =  ( slow_clock & incSelection && (digit == 10) ) ? 1 : 0;
assign doInc[11] =  ( slow_clock & incSelection && (digit == 11) ) ? 1 : 0;
assign doInc[12] =  ( slow_clock & incSelection && (digit == 12) ) ? 1 : 0;
assign doInc[13] =  ( slow_clock & incSelection && (digit == 13) ) ? 1 : 0;
assign doInc[14] =  ( slow_clock & incSelection && (digit == 14) ) ? 1 : 0;
assign doInc[15] =  ( slow_clock & incSelection && (digit == 15) ) ? 1 : 0;
assign doInc[16] =  ( slow_clock & incSelection && (digit == 16) ) ? 1 : 0;
assign doInc[17] =  ( slow_clock & incSelection && (digit == 17) ) ? 1 : 0;
assign doInc[18] =  ( slow_clock & incSelection && (digit == 18) ) ? 1 : 0;
assign doInc[19] =  ( slow_clock & incSelection && (digit == 19) ) ? 1 : 0;
assign doInc[20] =  ( slow_clock & incSelection && (digit == 20) ) ? 1 : 0;
assign doInc[21] =  ( slow_clock & incSelection && (digit == 21) ) ? 1 : 0;
assign doInc[22] =  ( slow_clock & incSelection && (digit == 22) ) ? 1 : 0;
assign doInc[23] =  ( slow_clock & incSelection && (digit == 23) ) ? 1 : 0;
assign doInc[24] =  ( slow_clock & incSelection && (digit == 24) ) ? 1 : 0;
assign doInc[25] =  ( slow_clock & incSelection && (digit == 25) ) ? 1 : 0;
assign doInc[26] =  ( slow_clock & incSelection && (digit == 26) ) ? 1 : 0;
assign doInc[27] =  ( slow_clock & incSelection && (digit == 27) ) ? 1 : 0;
assign doInc[28] =  ( slow_clock & incSelection && (digit == 28) ) ? 1 : 0;
assign doInc[29] =  ( slow_clock & incSelection && (digit == 29) ) ? 1 : 0;
assign doInc[30] =  ( slow_clock & incSelection && (digit == 30) ) ? 1 : 0;
assign doInc[31] =  ( slow_clock & incSelection && (digit == 31) ) ? 1 : 0;

endmodule
