
module sevenSegDisplay( clk, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, digit_out, segment_out );
input clk;
input [11:0] reg0;
input [11:0] reg1;
input [11:0] reg2;
input [11:0] reg3;
input [11:0] reg4;
input [11:0] reg5;
input [11:0] reg6;
input [11:0] reg7;
output [31:0] digit_out;
output [7:0] segment_out;
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
wire [2:0] regSel = cnt[13:11];
wire [1:0] digitSel = cnt[10:09];
wire [4:0] digit_ann = cnt[13:09];
reg [3:0] digit;

assign digit_out[ 0] = (digit_ann ==  5'd0 );
assign digit_out[ 1] = (digit_ann ==  5'd1);
assign digit_out[ 2] = (digit_ann ==  5'd2);
assign digit_out[ 3] = (digit_ann ==  5'd3);
assign digit_out[ 4] = (digit_ann ==  5'd4);
assign digit_out[ 5] = (digit_ann ==  5'd5);
assign digit_out[ 6] = (digit_ann ==  5'd6);
assign digit_out[ 7] = (digit_ann ==  5'd7);
assign digit_out[ 8] = (digit_ann ==  5'd8);
assign digit_out[ 9] = (digit_ann ==  5'd9);
assign digit_out[10] = (digit_ann == 5'd10);
assign digit_out[11] = (digit_ann == 5'd11);
assign digit_out[12] = (digit_ann == 5'd12);
assign digit_out[13] = (digit_ann == 5'd13);
assign digit_out[14] = (digit_ann == 5'd14);
assign digit_out[15] = (digit_ann == 5'd15);
assign digit_out[16] = (digit_ann == 5'd16);
assign digit_out[17] = (digit_ann == 5'd17);
assign digit_out[18] = (digit_ann == 5'd18);
assign digit_out[19] = (digit_ann == 5'd19);
assign digit_out[20] = (digit_ann == 5'd20);
assign digit_out[21] = (digit_ann == 5'd21);
assign digit_out[22] = (digit_ann == 5'd22);
assign digit_out[23] = (digit_ann == 5'd23);
assign digit_out[24] = (digit_ann == 5'd24);
assign digit_out[25] = (digit_ann == 5'd25);
assign digit_out[26] = (digit_ann == 5'd26);
assign digit_out[27] = (digit_ann == 5'd27);
assign digit_out[28] = (digit_ann == 5'd28);
assign digit_out[29] = (digit_ann == 5'd29);
assign digit_out[30] = (digit_ann == 5'd30);
assign digit_out[31] = (digit_ann == 5'd31);

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
  default: digit = 4'ha;
endcase

reg [7:0] SevenSeg;
always @(*)
case(digit)
    4'h0: SevenSeg = 8'b11111100;
    4'h1: SevenSeg = 8'b01100000;
    4'h2: SevenSeg = 8'b11011010;
    4'h3: SevenSeg = 8'b11110010;
    4'h4: SevenSeg = 8'b01100110;
    4'h5: SevenSeg = 8'b10110110;
    4'h6: SevenSeg = 8'b10111110;
    4'h7: SevenSeg = 8'b11100000;
    4'h8: SevenSeg = 8'b11111110;
    4'h9: SevenSeg = 8'b11110110;
    default: SevenSeg = 8'b00000000;
endcase
assign {segment_out[1],segment_out[2],segment_out[3],segment_out[4],segment_out[5],segment_out[6],segment_out[7],segment_out[0]} = ~SevenSeg;

endmodule
