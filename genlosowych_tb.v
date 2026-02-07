`timescale 1ns / 1ps

module test_genlosowych;

reg        CLK;
reg 		  RESET;
wire [8:0]		  OUT;

genlosowych UUT(.clk(CLK), .reset(RESET), .rand_val(OUT));

initial
		CLK = 0;
always #10 CLK = ~CLK;//clk 20ns 1 takt

initial
	begin
		#10000 RESET = 1;
		#10020 RESET = 0;
		#1000050 $finish;  //#500
	end

initial
	begin
		$dumpfile("genlosowych_tb.vcd");
		$dumpvars(0, UUT);
	end

endmodule

//(.clk(CLK),.reset(RESET),.btn(BTN),.press(START_PRESS),.release(START_RELEASE));