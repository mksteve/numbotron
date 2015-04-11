//////////////////////////////////////////////////////////
//
module EditRegs( clk, incDigit, incSelection, resetDigit, resetSel, slow_clock, slow_count, digit, doInc, doReset );
input clk;
input incDigit;      // ui for changing which digit to edit.
input incSelection;  // ui for incrementing digit.
input slow_clock;    // 1 clk input
input resetDigit; 
input resetSel;
input [31:0] slow_count;
output [4:0] digit;
output [31:0]doInc;
output [31:0]doReset;
wire [31:0]doReset;
reg [4:0] digit;
wire [1:0]relDigit = digit[1:0];

wire [31:0]doInc;
integer i;
always @(posedge clk, posedge resetDigit )
  if( resetDigit )
    digit <= 5'd0;
  else if( incDigit )
  begin
     if( digit == 5'd31 ) digit <= 0;
	  else if( relDigit == 2'h2 )digit <= digit + 5'h2;
	  else digit <= digit + 5'h1;
  end

  
assign doReset[0] =  (resetSel && (digit == 0) ) ? 1'h1 : 1'h0;
assign doReset[1] =  ( resetSel && (digit == 1) ) ? 1'h1 : 1'h0;
assign doReset[2] =  ( resetSel && (digit == 2) ) ? 1'h1 : 1'h0;
assign doReset[3] =  ( resetSel && (digit == 3) ) ? 1'h1 : 1'h0;
assign doReset[4] =  ( resetSel && (digit == 4) ) ? 1'h1 : 1'h0;
assign doReset[5] =  ( resetSel && (digit == 5) ) ? 1'h1 : 1'h0;
assign doReset[6] =  ( resetSel && (digit == 6) ) ? 1'h1 : 1'h0;
assign doReset[7] =  ( resetSel && (digit == 7) ) ? 1'h1 : 1'h0;
assign doReset[8] =  ( resetSel && (digit == 8) ) ? 1'h1 : 1'h0;
assign doReset[9] =  ( resetSel && (digit == 9) ) ? 1'h1 : 1'h0;
assign doReset[10] =  ( resetSel && (digit == 10) ) ? 1'h1 : 1'h0;
assign doReset[11] =  ( resetSel && (digit == 11) ) ? 1'h1 : 1'h0;
assign doReset[12] =  ( resetSel && (digit == 12) ) ? 1'h1 : 1'h0;
assign doReset[13] =  ( resetSel && (digit == 13) ) ? 1'h1 : 1'h0;
assign doReset[14] =  ( resetSel && (digit == 14) ) ? 1'h1 : 1'h0;
assign doReset[15] =  ( resetSel && (digit == 15) ) ? 1'h1 : 1'h0;
assign doReset[16] =  ( resetSel && (digit == 16) ) ? 1'h1 : 1'h0;
assign doReset[17] =  ( resetSel && (digit == 17) ) ? 1'h1 : 1'h0;
assign doReset[18] =  ( resetSel && (digit == 18) ) ? 1'h1 : 1'h0;
assign doReset[19] =  ( resetSel && (digit == 19) ) ? 1'h1 : 1'h0;
assign doReset[20] =  ( resetSel && (digit == 20) ) ? 1'h1 : 1'h0;
assign doReset[21] =  ( resetSel && (digit == 21) ) ? 1'h1 : 1'h0;
assign doReset[22] =  ( resetSel && (digit == 22) ) ? 1'h1 : 1'h0;
assign doReset[23] =  ( resetSel && (digit == 23) ) ? 1'h1 : 1'h0;
assign doReset[24] =  ( resetSel && (digit == 24) ) ? 1'h1 : 1'h0;
assign doReset[25] =  ( resetSel && (digit == 25) ) ? 1'h1 : 1'h0;
assign doReset[26] =  ( resetSel && (digit == 26) ) ? 1'h1 : 1'h0;
assign doReset[27] =  ( resetSel && (digit == 27) ) ? 1'h1 : 1'h0;
assign doReset[28] =  ( resetSel && (digit == 28) ) ? 1'h1 : 1'h0;
assign doReset[29] =  ( resetSel && (digit == 29) ) ? 1'h1 : 1'h0;
assign doReset[30] =  ( resetSel && (digit == 30) ) ? 1'h1 : 1'h0;
assign doReset[31] =  ( resetSel && (digit == 31) ) ? 1'h1 : 1'h0;


assign doInc[0] =  (incSelection && (digit == 0) ) ? 1'h1 : 1'h0;
assign doInc[1] =  ( incSelection && (digit == 1) ) ? 1'h1 : 1'h0;
assign doInc[2] =  ( incSelection && (digit == 2) ) ? 1'h1 : 1'h0;
assign doInc[3] =  ( incSelection && (digit == 3) ) ? 1'h1 : 1'h0;
assign doInc[4] =  ( incSelection && (digit == 4) ) ? 1'h1 : 1'h0;
assign doInc[5] =  ( incSelection && (digit == 5) ) ? 1'h1 : 1'h0;
assign doInc[6] =  ( incSelection && (digit == 6) ) ? 1'h1 : 1'h0;
assign doInc[7] =  ( incSelection && (digit == 7) ) ? 1'h1 : 1'h0;
assign doInc[8] =  ( incSelection && (digit == 8) ) ? 1'h1 : 1'h0;
assign doInc[9] =  ( incSelection && (digit == 9) ) ? 1'h1 : 1'h0;
assign doInc[10] =  ( incSelection && (digit == 10) ) ? 1'h1 : 1'h0;
assign doInc[11] =  ( incSelection && (digit == 11) ) ? 1'h1 : 1'h0;
assign doInc[12] =  ( incSelection && (digit == 12) ) ? 1'h1 : 1'h0;
assign doInc[13] =  ( incSelection && (digit == 13) ) ? 1'h1 : 1'h0;
assign doInc[14] =  ( incSelection && (digit == 14) ) ? 1'h1 : 1'h0;
assign doInc[15] =  ( incSelection && (digit == 15) ) ? 1'h1 : 1'h0;
assign doInc[16] =  ( incSelection && (digit == 16) ) ? 1'h1 : 1'h0;
assign doInc[17] =  ( incSelection && (digit == 17) ) ? 1'h1 : 1'h0;
assign doInc[18] =  ( incSelection && (digit == 18) ) ? 1'h1 : 1'h0;
assign doInc[19] =  ( incSelection && (digit == 19) ) ? 1'h1 : 1'h0;
assign doInc[20] =  ( incSelection && (digit == 20) ) ? 1'h1 : 1'h0;
assign doInc[21] =  ( incSelection && (digit == 21) ) ? 1'h1 : 1'h0;
assign doInc[22] =  ( incSelection && (digit == 22) ) ? 1'h1 : 1'h0;
assign doInc[23] =  ( incSelection && (digit == 23) ) ? 1'h1 : 1'h0;
assign doInc[24] =  ( incSelection && (digit == 24) ) ? 1'h1 : 1'h0;
assign doInc[25] =  ( incSelection && (digit == 25) ) ? 1'h1 : 1'h0;
assign doInc[26] =  ( incSelection && (digit == 26) ) ? 1'h1 : 1'h0;
assign doInc[27] =  ( incSelection && (digit == 27) ) ? 1'h1 : 1'h0;
assign doInc[28] =  ( incSelection && (digit == 28) ) ? 1'h1 : 1'h0;
assign doInc[29] =  ( incSelection && (digit == 29) ) ? 1'h1 : 1'h0;
assign doInc[30] =  ( incSelection && (digit == 30) ) ? 1'h1 : 1'h0;
assign doInc[31] =  ( incSelection && (digit == 31) ) ? 1'h1 : 1'h0;


endmodule
