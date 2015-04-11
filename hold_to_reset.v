module longPressReset( clk, inPress, doReset );
input clk;
input inPress;
output reg doReset;
reg [2:0]count;


always @(posedge clk )
begin
  if( inPress )
    begin
     if ( &count ) doReset <= 1;
	  else doReset <= 0;
     count <= count + 2'h1;
	 end
  else
    begin
     count <= 0;
	  doReset <= 0;
	 end
end

endmodule