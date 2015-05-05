module fullReset( resetButton, resetRegs, resetDigitFull );
input resetButton;
output [31:0]resetRegs;
output resetDigitFull;
reg [31:0]resetRegs;
reg resetDigitFull;

always @(resetButton) 
 if( resetButton )
   begin 
	  resetRegs = 31'hffffffff;
	  resetDigitFull = 1;
	end
 else 
   begin 
	  resetRegs = 31'h0;
	  resetDigitFull = 0;
	end

 endmodule
 