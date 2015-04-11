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
  instructions[0] = 24'h020101;
end

always @(*) ip = instruction_pointer;
always @(posedge clk) 
if (slowclk ) dostep <= 1;
else dostep <= 0;

assign dec_regs[0] = 1'h1;

assign current_instruction = instructions[instruction_pointer];
endmodule
