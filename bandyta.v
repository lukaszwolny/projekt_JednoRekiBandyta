//////////////////////////////////////////////////////////////////////////////////
// Company: polsl
// Engineer: Lukasz Wolny
// 
// Create Date: 24.06.2025 12:14:36
// Design Name: Jednoręki bandyta
// Module Name: bandyta
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bandyta(
	input CLK,//zegar
	input BTN,//Przycisk START
	input rst,//Reset globalny
	
	//input BTND,//Reset dla reset_release - TYMCZASOWE do testow
	
	//wyswietlacz
	output  [6:0] seg,//7-seg 1
	output  [6:0] seg2,//7-seg 2
	output  [6:0] seg3,//7-seg 3
	//diody
	//Do testow
	output dioda_press,
	output dioda_release,
	output dioda_done5s,
	output dioda_stop1,
	output dioda_stop2,
	output dioda_stop3
	
);
//------------------------------
//pomocnicze sygnaly

//wire RESET; // do reset_release.
wire START_PRESS;
wire START_RELEASE;
wire OUT; //wyjscie licznik1ms
wire Done_5s;
wire START_5s;
wire [8:0] RAND_VAL;

wire stop1;
wire stop2;
wire stop3;

wire [2:0] SYMBOL1;
wire [2:0] SYMBOL2;
wire [2:0] SYMBOL3;

wire [7:0] punkty_dec;
wire [3:0] punkty_jedn;
wire [3:0] punkty_dzies;
wire [3:0] punkty_set;

//------------------------------
//Instancje

/* Na płytce Intela przyciski aktywne stanem 0, Artix-7 aktywne 1. */
przycisk modul_przycisku(.clk(CLK), .reset(~rst), .btn(~BTN),.reset_release(Done_5s), .btn_press(START_PRESS), .btn_release(START_RELEASE));
licznik1ms modul_licznik1ms(.clk(CLK), .reset(~rst), .out(OUT));
licznik5s modul_licznik5s(.clk(CLK), .reset(~rst), .en(OUT), .start(START_5s), .done(Done_5s));
genlosowych modul_genlosowych(.clk(CLK), .reset(~rst), .rand_val(RAND_VAL));

beben #(.X_param(2)) beben1(.clk(CLK), .reset(~rst), .btn_press(START_PRESS), .btn_release(START_RELEASE), .val(RAND_VAL[2:0]), .symbol(SYMBOL1), .stop(stop1));
beben #(.X_param(1)) beben2(.clk(CLK), .reset(~rst), .btn_press(START_PRESS), .btn_release(START_RELEASE), .val(RAND_VAL[5:3]), .symbol(SYMBOL2), .stop(stop2));
beben #(.X_param(0)) beben3(.clk(CLK), .reset(~rst), .btn_press(START_PRESS), .btn_release(START_RELEASE), .val(RAND_VAL[8:6]), .symbol(SYMBOL3), .stop(stop3));

//łączenie tych 3 stop.
assign START_5s = stop1 & stop2 & stop3;

logika_wygranej punktacja(.symb1(SYMBOL1), .symb2(SYMBOL2), .symb3(SYMBOL3), .en(START_5s), .punkty(punkty_dec));
bin_to_bcd bcd(.punktacja(punkty_dec), .punkty1(punkty_jedn), .punkty2(punkty_dzies), .punkty3(punkty_set));

//wyswietlanie
wyswietlanie wys(.clk(CLK), .reset(~rst), .s1(SYMBOL1), .s2(SYMBOL2), .s3(SYMBOL3), .p1(punkty_jedn), .p2(punkty_dzies), .p3(punkty_set), .done(Done_5s), .seg1(seg), .seg2(seg2), .seg3(seg3));

//Diody testy
assign dioda_press = START_PRESS;//~BTNC;
assign dioda_release = START_RELEASE;//~BTND; 
assign dioda_done5s = Done_5s;
assign dioda_stop1 = stop1;
assign dioda_stop2 = stop2;
assign dioda_stop3 = stop3;


endmodule