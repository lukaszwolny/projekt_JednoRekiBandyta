`timescale 1ns / 1ps

module test_przycisk;

reg        CLK;
reg        rst;
reg        RESET;
reg		  BTN;
wire 		  START_PRESS;
wire 		  START_RELEASE;

przycisk UUT(.clk(CLK), .reset(rst), .btn(BTN), .reset_release(RESET), .btn_press(START_PRESS), .btn_release(START_RELEASE));

initial
		CLK = 0;
always #10 CLK = ~CLK;//clk 20ns 1 takt

initial
	begin
		#0 BTN = 0;//nie wciesniety
		#0 RESET = 0;
		#0 rst = 0;
		#10 rst = 1;
		#30 rst = 0;
		#50 BTN = 1;
		#50 BTN = 0;

		#100 BTN = 1;//przycisk trzymany  -> press=1
		#50 BTN = 0;//przycisk puszczony -> release=1,press=0
		//teraz jak release=1 , klikanie nic nie da.
		#50 BTN = 1;
		#50 BTN = 0;
		#50 BTN = 1;
		#50 BTN = 0;
		//Teraz reset sie pojawia
		#50 RESET = 1;
		#20 RESET = 0;
		#50 BTN = 1;//po resecie znowu da sie klikac
		#50 BTN = 0;

		#10 RESET = 1;
		#50 RESET = 0;

		#500 $finish;
	end

initial
	begin
		$dumpfile("przycisk_tb.vcd");
		$dumpvars(0, UUT);
	end

endmodule

//(.clk(CLK),.reset(RESET),.btn(BTN),.press(START_PRESS),.release(START_RELEASE));