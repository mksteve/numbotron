module segmentDisplay( value, segments );
input [4:0]value;
output reg [7:0]segments;

always @(value)
case(value)
  5'h0   : segments = ~ 8'b01111110;
  5'h1   : segments = ~ 8'b00001100;
  5'h2   : segments = ~ 8'b10110110;
  5'h3   : segments = ~ 8'b10011110;
  5'h4   : segments = ~ 8'b11001100;
  5'h5   : segments = ~ 8'b11011010;
  5'h6   : segments = ~ 8'b11111010;
  5'h7   : segments = ~ 8'b00001110;
  5'h8   : segments = ~ 8'b11111110;
  5'h9   : segments = ~ 8'b11001110;
  5'ha   : segments = ~ 8'b11101110; // A;
  5'hb   : segments = ~ 8'b11111000; // b;
  5'hc   : segments = ~ 8'b01110010; // C;
  5'hd   : segments = ~ 8'b10111100; // d;
  5'he   : segments = ~ 8'b11110010; // E?
  5'hf   : segments = ~ 8'b11100010; // F?
  5'h10  : segments = ~ 8'b01110000; // L?
  5'h11  : segments = ~ 8'b10101000; // n?
  5'h12  : segments = ~ 8'b11100110; // P?
  default: segments = ~ 8'b00000000; // all off.
endcase
endmodule

