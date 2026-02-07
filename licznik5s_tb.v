`timescale 1ns / 1ps

module test_licznik5s;

reg        CLK;
reg        RESET;
wire		  OUT;
reg 		  START_5s;
wire 		  Done_5s;

licznik1ms UUT2(.clk(CLK), .reset(RESET), .out(OUT));
licznik5s UUT(.clk(CLK), .reset(RESET), .en(OUT), .start(START_5s), .done(Done_5s));

initial
		CLK = 1;
always #10 CLK = ~CLK;//clk 20ns 1 takt

//initial
//		OUT = 0;
//always #20 OUT = ~OUT;

initial
	begin
		//#0 OUT = 0;//nie wciesniety
		#0 START_5s = 0;
		#0 RESET = 0;
		//#30 OUT = 1;//przycisk trzymany  -> press=1
		//#20 START_5s = 0;//przycisk puszczony -> release=1,press=0
		//#20 OUT = 0;
		#30 RESET = 1;
		#10 RESET = 0;

		#100 START_5s = 1;
	   #400200 START_5s = 0;
		#200200 START_5s = 1;
		
		#10000100 $finish;  //#1000050
	end

initial
	begin
		$dumpfile("licznik5s_tb.vcd");
		$dumpvars();
	end

endmodule

//licznik5s modul_licznik5s(.clk(CLK), .en(OUT), .start(START_5s), .done(Done_5s));