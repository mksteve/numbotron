module Debounce( clk, button, debouncedState, onChangeOn, onChangeOff );
input clk;
input button;
output debouncedState;
output onChangeOn;
output onChangeOff;

reg debouncedState;

reg onChangeOn;
reg onChangeOff;
reg flop1;
reg flop2;
reg [15:0] counter;
always @(posedge clk) flop1 <= button;
always @(posedge clk) flop2 <= flop1;

wire stable = (flop2 == debouncedState );
wire loopDone = counter> 16'hfffd;

always @(posedge clk)
begin
if (stable)
   begin 
	   if( loopDone )
		begin
		  counter <= counter + 1;
		  if( &counter ) counter <= 0;
	     if( flop2 )
		    onChangeOn <= 1;
		   else 
		    onChangeOff <= 1;
	   end
		else
		   begin
		     counter <= 0; // reset.
			  onChangeOff <= 0;
			  onChangeOn <= 0;
			end
   end
else
   begin
	  counter <= counter + 15'd1;
	  if( loopDone ) debouncedState <= flop2;
	end
end
//assign onChangeOn = stable & loopDone & flop2;
//assign onChangeOff = stable & loopDone & (flop2 == 1'h0 );

endmodule
