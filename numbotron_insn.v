/////////////////////////////////////////
// numbotron instructions

module thread( clk, slowclk, rstb, step, reg_0, inc_regs, dec_regs, dostep, ip, running_out );
input clk;
input rstb;
input slowclk;  // slow down clock so we can see it working
input step;     // single step button
input [7:0] reg_0;
output [7:0] inc_regs;
output [7:0] dec_regs;
output dostep;  // should we run inc / dec?
output [4:0] ip;
output running_out;
wire running_out;
wire [24:0] current_instruction;
reg instruction_finished = 1;  // has the current instruction completed?
reg running = 1;               // are we running? (or editing)
reg stepping;                  // are we single stepping?
assign running_out = running;
reg [4:0] instruction_pointer; // what are we working on?

reg [24:0] instructions [0:24];
reg [7:0] reg_insn_zero;
reg [7:0] reg_insn_inc;
reg [7:0] reg_insn_dec;
wire [7:0] inc_regs;
wire [7:0] dec_regs;
reg dostep;
reg [4:0] ip;

initial begin
  instructions[0] = 24'h000808; // set reg 3 to 0.
  instructions[1] = 24'h0a0101; // add reg 0 => reg 1, set reg 3 to reg 0
  instructions[2] = 24'h000404; // set reg 2 to 0.
  instructions[3] = 24'h040202; // copy reg 1 => reg 2
end

always @(*) ip = instruction_pointer;

always @(posedge clk )
if (rstb)
	begin
	 stepping <= 0;
	 instruction_finished <= 1;
	 instruction_pointer <= 0;
    running <= 1;
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
				running <= 0;
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
