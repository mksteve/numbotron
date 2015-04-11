/////////////////////////////////////////////////////////////
// numbotron register

module NUMReg( clk, slowclk, reg_inc, reg_dec, reg_inc_dig, reg_val, reg_z );
input clk;
input slowclk;
input reg_inc;
input reg_dec;
input [2:0] reg_inc_dig;
output [4*3-1:0] reg_val; // 3 4bit values
output reg_z;

wire [2:0] reg_inc_dig;
wire [2:0] inc_carry;
wire [2:0] dec_carry;
wire [2:0] is_zero;
wire [11:0] reg_val;

assign inc_carry[0] = reg_inc & slowclk;
assign dec_carry[0] = reg_dec & slowclk;
BCD dig1( .clk(clk),
          .doinc( inc_carry[0] | ( reg_inc_dig[0] ) ), 
          .dodec(dec_carry[0]),
			 .digit( reg_val[3:0]),
			 .iszero( is_zero[0]), 
			 .isoverflow(inc_carry[1]),
			 .isunderflow(dec_carry[1]) );
BCD dig2( .clk(clk),
          .doinc( (inc_carry[1] &slowclk) | ( reg_inc_dig[1] ) ), 
          .dodec(dec_carry[1]),
			 .digit( reg_val[7:4]),
			 .iszero( is_zero[1]), 
			 .isoverflow(inc_carry[2]),
			 .isunderflow(dec_carry[2]) );
BCD dig3( .clk(clk),
          .doinc( (slowclk & inc_carry[2] ) | ( reg_inc_dig[2] ) ), 
          .dodec(dec_carry[2]),
			 .digit( reg_val[11:8]),
			 .iszero( is_zero[2])    );
	assign reg_z = is_zero[0] & is_zero[1] & is_zero[2];
endmodule

module BCD( clk, doinc, dodec, digit, iszero,isoverflow, isunderflow );
input clk;
input doinc;
input dodec;
output [3:0]digit;
output iszero;
output isoverflow;
output isunderflow;
reg [3:0] digit;



wire incrollover = (digit==4'd9);
wire decrollover = (digit==4'd0);
always @(posedge clk)
begin


  if(  doinc )
	  begin
	    if( digit == 4'd9 ) 
			 begin 
			   digit <= 4'd0;
			 end
		 else 
		   begin
			  digit <= digit + 4'd1;
			end
	  end
  else if ( dodec )
	  begin
	    if( digit == 4'd0 ) digit <= 4'd9;
		 else digit <= digit - 4'd1;
		 
	  end
end 
assign isoverflow = incrollover & ( doinc );
assign isunderflow = decrollover & (dodec );
assign iszero = (( doinc  && digit == 4'd9 ) || 
						(dodec && digit == 4'd1)   ||
						((dodec ==0 && doinc == 0) && digit == 4'd0 )) ? 1'd1 : 1'd0;
endmodule
