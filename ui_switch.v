/////////////////////////
// ui selector - are we editing the registers or the instructions

module EditModeSelector( clk, modeSelector, digitChange, digitInc, reset_digit, reset_value, is_running, mode_reset,
                         display_mode, 
                         reg_digitchange, reg_digitinc, reg_digitreset, reg_valuereset,
								 insn_digitchange, insn_digitinc, insn_digitreset, insn_valuereset );
								
input clk;
input modeSelector;
input digitChange;
input digitInc;
input reset_digit;
input reset_value;
input is_running;
input mode_reset;
output display_mode;

output reg_digitchange, reg_digitinc, reg_digitreset, reg_valuereset;
output insn_digitchange, insn_digitinc, insn_digitreset, insn_valuereset;

reg editMode;  // 0 = reg, 1 = insn

always @(posedge clk )
  if(mode_reset)
    editMode <= 0;
  else if(modeSelector)
   editMode <= ~ editMode;

assign display_mode = (is_running == 1 || editMode == 0 ) ? 1'h0 : 1'h1;
assign reg_digitchange = (is_running == 0 && editMode == 0) ? digitChange : 1'h0;
assign reg_digitinc    = (is_running == 0 && editMode == 0) ? digitInc    : 1'h0;
assign reg_digitreset  = (is_running == 0 && editMode == 0) ? reset_digit : 1'h0;
assign reg_valuereset  = (is_running == 0 && editMode == 0) ? reset_value : 1'h0;

assign insn_digitchange = (is_running == 0 && editMode == 1) ? digitChange : 1'h0;
assign insn_digitinc    = (is_running == 0 && editMode == 1) ? digitInc    : 1'h0;
assign insn_digitreset  = (is_running == 0 && editMode == 1) ? reset_digit : 1'h0;
assign insn_valuereset  = (is_running == 0 && editMode == 1) ? reset_value : 1'h0;

endmodule
