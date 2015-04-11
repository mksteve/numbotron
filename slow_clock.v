

module slow_clock (input clock , output reg [31:0] counter_out, output reg slow_clock, output reg [31:0] slow_count );
always @ (posedge clock)// on positive clock edge
begin
if( counter_out == 31'd2000000 )
  begin
    counter_out <= 0;
	 slow_clock <= 1;
	 slow_count <= slow_count + 1;
  end
else
   begin
     counter_out <= #1 counter_out + 1;// increment counter
	  slow_clock <= 0;
	end
end
endmodule

