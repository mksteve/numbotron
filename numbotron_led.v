
module sevenSegDisplay( clk, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, digit_out, display_out );
input clk;
input [11:0] reg0;
input [11:0] reg1;
input [11:0] reg2;
input [11:0] reg3;
input [11:0] reg4;
input [11:0] reg5;
input [11:0] reg6;
input [11:0] reg7;
output [4:0] digit_out;
output [4:0] display_out;
wire [11:0] reg0;
wire [11:0] reg1;
wire [11:0] reg2;
wire [11:0] reg3;
wire [11:0] reg4;
wire [11:0] reg5;
wire [11:0] reg6;
wire [11:0] reg7;

reg [11:0] current_reg;

reg [23:0] cnt;
always @(posedge clk) cnt<=cnt+24'h1;

wire cntovf = &cnt;
wire [4:0] digit_ann = cnt[13:09];
wire [2:0] regSel = digit_ann[4:2];
wire [1:0] digitSel = digit_ann[1:0];
reg [4:0] digit;

assign digit_out = digit_ann;

always @(*)
case( regSel )
  3'd0: current_reg = reg0;
  3'd1: current_reg = reg1;
  3'd2: current_reg = reg2;
  3'd3: current_reg = reg3;
  3'd4: current_reg = reg4;
  3'd5: current_reg = reg5;
  3'd6: current_reg = reg6;
  3'd7: current_reg = reg7;
endcase

always @(*)
case(digitSel)
  2'd0: digit = current_reg[3:0];
  2'd1: digit = current_reg[7:4];
  2'd2: digit = current_reg[11:8];
  default: digit = 5'h1f;
endcase

assign display_out[4] = digit[4] ;
assign display_out[3] = digit[3];
assign display_out[2] = digit[2];
assign display_out[1] = digit[1];
assign display_out[0] = digit[0];
endmodule
