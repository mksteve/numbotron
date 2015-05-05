/////////////////////////////////////////
// numbotron instructions

module thread( clk, slowclk, rstb, step, reg_0, inc_digit,inc_value, reset_digit, reset_value, reset_all, inc_regs, dec_regs, dostep, ip, running_out, digit_out, digit_val, curr_dig );
input clk;
input rstb;
input slowclk;  // slow down clock so we can see it working
input step;     // single step button
input [7:0] reg_0;
input inc_digit;
input inc_value;
input reset_digit;
input reset_value;
input reset_all;
output [7:0] inc_regs;
output [7:0] dec_regs;
output [4:0] digit_out; // ui display the segments of the led.
output [4:0] digit_val; // ui display the segment of the led.
output [4:0] curr_dig;  // ui display the edit value.
output dostep;  // should we run inc / dec?
output [4:0] ip;
output running_out;
wire running_out;
wire [24:0] current_instruction;
reg instruction_finished = 1;  // has the current instruction completed?
reg running = 0;               // are we running? (or editing)
reg stepping;                  // are we single stepping?
assign running_out = running;
reg [4:0] instruction_pointer; // what are we working on?
reg [4:0]curr_dig;

reg [24:0] instructions [0:24];
initial instructions[0] =   25'h000808; // set reg 3 to 0.
initial instructions[1] =   25'h0a0101; // add reg 0 => reg 1, set reg 3 to reg 0
initial instructions[2] =   25'h000404; // set reg 2 to 0.
initial instructions[3] =   25'h040202; // copy reg 1 => reg 2
initial instructions[4] =   25'h000000;  // end
//
// fibonacci
// inital reg 0 = 1, reg 1 = 1
//    +=========== increment
//    | +========= decrement
//    | | +======= test for zero
//    V V V
// 0x040101
// 0x050202
// 0x020404
//
//
reg [7:0] reg_insn_zero;
reg [7:0] reg_insn_inc;
reg [7:0] reg_insn_dec;
wire [7:0] inc_regs;
wire [7:0] dec_regs;
reg dostep;
reg [4:0] ip;
reg [14:0]digit_count;
wire [4:0] digit_out = digit_count[11:7];
reg [7:0] loop;  // how many times to loop.
reg [2:0] page;  // page 0 => 7
reg [8:0] loop_remain;
reg [4:0] digit_val;


always @(posedge clk)
 if( reset_all )
	 curr_dig <= 0;
 else if(reset_digit)
   curr_dig <= 0;
 else if( inc_digit)
  case( curr_dig )
    5'd0 : curr_dig <= 1; // loop 0 => 1
	 5'd1 : curr_dig <= 4; // loop 1 => p0
	 5'd4 : curr_dig <= 12; // p0 => insn[0]n0

	 5'd12 : curr_dig <= 13; // insn[0]n0 => insn[0]n1
	 5'd13 : curr_dig <= 14; // insn[0]n1 => insn[0]n2
	 5'd14 : curr_dig <= 15; // insn[0]n2 => insn[0]n3
	 5'd15 : curr_dig <= 8;  // insn[0]n3 => insn[0]n4
	 5'd8  : curr_dig <= 9;  // insn[0]n4 => insn[0]n5
	 5'd9  : curr_dig <= 20;  // insn[0]n5 => insn[1]n0

	 5'd20  : curr_dig <= 21;  // insn[1]n0 => insn[1]n1
	 5'd21  : curr_dig <= 22;  // insn[1]n1 => insn[1]n2
	 5'd22  : curr_dig <= 23;  // insn[1]n2 => insn[1]n3
	 5'd23  : curr_dig <= 16;  // insn[1]n3 => insn[1]n4
	 5'd16  : curr_dig <= 17;  // insn[1]n4 => insn[1]n5
	 5'd17  : curr_dig <= 28;  // insn[1]n5 => insn[2]n6

	 5'd28  : curr_dig <= 29;  // insn[1]n0 => insn[1]n1
	 5'd29  : curr_dig <= 30;  // insn[1]n1 => insn[1]n2
	 5'd30  : curr_dig <= 31;  // insn[1]n2 => insn[1]n3
	 5'd31  : curr_dig <= 24;  // insn[1]n3 => insn[1]n4
	 5'd24  : curr_dig <= 25;  // insn[1]n4 => insn[1]n5
	 5'd25  : curr_dig <= 00;  // insn[1]n5 => insn[2]n6


	 default: curr_dig <= curr_dig + 1;
  endcase
 wire [3:0]loop_high = loop[7:4];
 wire [3:0]loop_low  = loop[3:0];

wire [23:0] ui_insn;
initial 
begin
  instructions[0] = 25'h000808; // set reg 3 to 0.
  instructions[1] = 25'h0a0101; // add reg 0 => reg 1, set reg 3 to reg 0
  instructions[2] = 25'h000404; // set reg 2 to 0.
  instructions[3] = 25'h040202; // copy reg 1 => reg 2
end

reg [24:0] line1;
reg [24:0] line2;
reg [24:0] line3;
always @(*)
case( page)
 3'd0: 
   begin 
	  line1 = instructions[0];
	  line2 = instructions[1];
	  line3 = instructions[2];
	end
 3'd1: 
   begin 
	  line1 = instructions[3];
	  line2 = instructions[4];
	  line3 = instructions[5];
	end
 3'd2:
   begin 
	  line1 = instructions[6];
	  line2 = instructions[7];
	  line3 = instructions[8];
	end
 3'd3:
   begin 
	  line1 = instructions[9];
	  line2 = instructions[10];
	  line3 = instructions[11];
	end
 3'd4:
   begin 
	  line1 = instructions[12];
	  line2 = instructions[13];
	  line3 = instructions[14];
	end
 3'd5:
   begin 
	  line1 = instructions[15];
	  line2 = instructions[16];
	  line3 = instructions[17];
	end
 3'd6:
   begin 
	  line1 = instructions[18];
	  line2 = instructions[19];
	  line3 = instructions[20];
	end
 3'd7:
   begin 
	  line1 = instructions[21];
	  line2 = instructions[22];
	  line3 = instructions[23];
	end
 default:
   begin 
	  line1 = instructions[0];
	  line2 = instructions[1];
	  line3 = instructions[2];
	end
   
endcase 

always @(*) ip = instruction_pointer;
always @(*)
case( digit_out)
  5'd0: digit_val = loop[3:0];  // current loop settings 00 => ff
  5'd1: digit_val = loop[7:4];  // loop settings  
  5'd3: digit_val = 5'h10;      // 'L'
  5'd4: digit_val = page[2:0];  // page - 0=>7
  5'd7: digit_val = 5'h12;      // 'P'
  5'd12: digit_val = line1[3:0];
  5'd13: digit_val = line1[7:4];
  5'd14: digit_val = line1[11:8];
  5'd15: digit_val = line1[15:12];
   5'd8: digit_val = line1[19:16];
   5'd9: digit_val = line1[23:20];
	
  5'd20: digit_val = line2[3:0];
  5'd21: digit_val = line2[7:4];
  5'd22: digit_val = line2[11:8];
  5'd23: digit_val = line2[15:12];
   5'd16: digit_val = line2[19:16];
   5'd17: digit_val = line2[23:20];

  5'd28: digit_val = line3[3:0];
  5'd29: digit_val = line3[7:4];
  5'd30: digit_val = line3[11:8];
  5'd31: digit_val = line3[15:12];
   5'd24: digit_val = line3[19:16];
   5'd25: digit_val = line3[23:20];

	
	default: digit_val = 5'h1f; 
endcase
always @(posedge clk) 	 digit_count <= digit_count + 15'd1;

always @(posedge clk )
if (rstb)
	begin
//	instructions[0] = 25'h000808; // set reg 3 to 0.
//	instructions[1] = 25'h0a0101; // add reg 0 => reg 1, set reg 3 to reg 0
//	instructions[2] = 25'h000404; // set reg 2 to 0.
//	instructions[3] = 25'h040202; // copy reg 1 => reg 2
	
	 stepping <= 0;
	 instruction_finished <= 1;
	 instruction_pointer <= 0;
    running <= 1;
	 loop_remain <= loop;
	end
else if ( reset_all )
  begin
    instructions[0] <= 25'h0000000;
    instructions[1] <= 25'h0000000;
    instructions[2] <= 25'h0000000;
    instructions[3] <= 25'h0000000;
    instructions[4] <= 25'h0000000;
    instructions[5] <= 25'h0000000;
    instructions[6] <= 25'h0000000;
    instructions[7] <= 25'h0000000;
    instructions[8] <= 25'h0000000;
    instructions[9] <= 25'h0000000;
    instructions[10] <= 25'h0000000;
    instructions[11] <= 25'h0000000;
    instructions[12] <= 25'h0000000;
    instructions[13] <= 25'h0000000;
    instructions[14] <= 25'h0000000;
    instructions[15] <= 25'h0000000;
    instructions[16] <= 25'h0000000;
    instructions[17] <= 25'h0000000;
    instructions[18] <= 25'h0000000;
    instructions[19] <= 25'h0000000;
    instructions[20] <= 25'h0000000;
    instructions[21] <= 25'h0000000;
    instructions[22] <= 25'h0000000;
    instructions[23] <= 25'h0000000;
	 loop <= 0;
	 page <= 0;
	 running <= 0;
	 instruction_pointer <=0;
	 instruction_finished<=1;
	 stepping<=0;
  end
else if( inc_value )
  begin
    if (curr_dig == 0 )
	   loop <= loop_high * 16 + ((loop_low + 1 ) & 4'hf);
	 else if( curr_dig == 1)
	   loop <= ((loop_high  + 1) &4'hf)* 16 + loop_low;
	 else if( curr_dig == 4)
	   page <= page + 3'h1;
		
	 else if( curr_dig == 12)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1fffff0 | ((( instructions[page*3] & 25'h000000f ) + 25'h1) &25'h000000f );
	 else if( curr_dig == 13)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1ffff0f | ((( instructions[page*3] & 25'h00000f0 ) + 25'h10) &25'h00000f0 );
	 else if( curr_dig == 14)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1fff0ff | ((( instructions[page*3] & 25'h0000f00 ) + 25'h100) &25'h0000f00 );
	 else if( curr_dig == 15)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1ff0fff | ((( instructions[page*3] & 25'h000f000 ) + 25'h1000) &25'h000f000 );
	 else if( curr_dig ==  8)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1f0ffff | ((( instructions[page*3] & 25'h00f0000 ) + 25'h10000) &25'h00f0000 );
	 else if( curr_dig ==  9)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h10fffff | ((( instructions[page*3] & 25'h0f00000 ) + 25'h100000) &25'h0f00000 );

	 else if( curr_dig == 20)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1fffff0 | ((( instructions[page*3+1] & 25'h000000f ) + 25'h1) &25'h000000f );
	 else if( curr_dig == 21)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1ffff0f | ((( instructions[page*3+1] & 25'h00000f0 ) + 25'h10) &25'h00000f0 );
	 else if( curr_dig == 22)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1fff0ff | ((( instructions[page*3+1] & 25'h0000f00 ) + 25'h100) &25'h0000f00 );
	 else if( curr_dig == 23)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1ff0fff | ((( instructions[page*3+1] & 25'h000f000 ) + 25'h1000) &25'h000f000 );
	 else if( curr_dig == 16)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1f0ffff | ((( instructions[page*3+1] & 25'h00f0000 ) + 25'h10000) &25'h00f0000 );
	 else if( curr_dig == 17)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h10fffff | ((( instructions[page*3+1] & 25'h0f00000 ) + 25'h100000) &25'h0f00000 );

	 else if( curr_dig == 28)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1fffff0 | ((( instructions[page*3+2] & 25'h000000f ) + 25'h1) &25'h000000f );
	 else if( curr_dig == 29)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1ffff0f | ((( instructions[page*3+2] & 25'h00000f0 ) + 25'h10) &25'h00000f0 );
	 else if( curr_dig == 30)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1fff0ff | ((( instructions[page*3+2] & 25'h0000f00 ) + 25'h100) &25'h0000f00 );
	 else if( curr_dig == 31)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1ff0fff | ((( instructions[page*3+2] & 25'h000f000 ) + 25'h1000) &25'h000f000 );
	 else if( curr_dig == 24)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1f0ffff | ((( instructions[page*3+2] & 25'h00f0000 ) + 25'h10000) &25'h00f0000 );
	 else if( curr_dig == 25)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h10fffff | ((( instructions[page*3+2] & 25'h0f00000 ) + 25'h100000) &25'h0f00000 );
	end
else if( reset_value)
  begin
	 if( curr_dig == 12)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1fffff0;
	 else if( curr_dig == 13)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1ffff0f;
	 else if( curr_dig == 14)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1fff0ff;
	 else if( curr_dig == 15)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1ff0fff;
	 else if( curr_dig ==  8)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h1f0ffff;
	 else if( curr_dig ==  9)
	   instructions[page * 3 ] <=  instructions[page * 3 ] & 25'h10fffff;

	 else if( curr_dig == 20)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1fffff0;
	 else if( curr_dig == 21)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1ffff0f;
	 else if( curr_dig == 22)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1fff0ff;
	 else if( curr_dig == 23)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1ff0fff;
	 else if( curr_dig == 16)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h1f0ffff;
	 else if( curr_dig == 17)
	   instructions[page * 3 +1] <=  instructions[page * 3 +1] & 25'h10fffff;

	 else if( curr_dig == 28)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1fffff0;
	 else if( curr_dig == 29)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1ffff0f;
	 else if( curr_dig == 30)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1fff0ff;
	 else if( curr_dig == 31)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1ff0fff;
	 else if( curr_dig == 24)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h1f0ffff;
	 else if( curr_dig == 25)
	   instructions[page * 3 +2] <=  instructions[page * 3 +2] & 25'h10fffff;
  end
else
	begin
    running <= running;
	 stepping <= stepping;
		////////////////
		// load next instruction?
		// yes if 
		// 1) instruction completed and correct clock (slowclk)
		//   a) running
		//   b) stepping and step button pressed.
		//
		if( !slowclk )
		   dostep <= 0;
		else if (instruction_finished & (running || (!stepping || step ))  )
		begin
			reg_insn_zero = current_instruction[7:0];
			instruction_pointer = instruction_pointer + 5'd1;
			if( reg_insn_zero == 8'h00)
			 begin
			   instruction_pointer = 0;
				if( loop_remain == 0 )
				  running <= 0;
				else
				  loop_remain <= loop_remain - 1;
		    end
			else if (reg_insn_zero & reg_0 )
			   begin
				  instruction_finished = 1;
				  reg_insn_dec = 8'd0;
				  reg_insn_inc = 8'd0;
				  dostep <= 0;
			   end
			else
			   begin
				  instruction_finished = 0;
				  reg_insn_dec = current_instruction[15:8];
				  reg_insn_inc = current_instruction[23:16];
				end
		end
		else 
		/////////////////////////////////////////////////////////////
		// step on instruction
		// if running or stepping 
		if ( !instruction_finished & (running | stepping))
		begin
			if (reg_insn_zero & reg_0 )
			   begin
					instruction_finished = 1;
				end
			else
				begin
				  dostep <= 1;
				end
		end
	end
assign current_instruction = instructions[instruction_pointer];
assign inc_regs = reg_insn_inc;
assign dec_regs = reg_insn_dec;

endmodule
