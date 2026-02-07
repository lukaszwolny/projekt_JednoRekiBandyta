`timescale 1ns / 1ps

module test_licznik1ms;

reg        CLK;
reg        RESET;
wire 		  OUT;

licznik1ms UUT(.clk(CLK), .reset(RESET), .out(OUT));

initial
		CLK = 0;
always #10 CLK = ~CLK;//clk 20ns 1 takt

initial
	begin
		#0 RESET = 0;
		#10 RESET = 1;
		#20 RESET = 0;


		#1000050 $finish;  //#500
	end

initial
	begin
		$dumpfile("licznik1ms_tb.vcd");
		$dumpvars(0, UUT);
	end

endmodule

//(.clk(CLK),.reset(RESET),.btn(BTN),.press(START_PRESS),.release(START_RELEASE));