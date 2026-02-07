module bin_to_bcd(
    input [7:0] punktacja,
    output [3:0] punkty1,//jednosci
    output [3:0] punkty2,//dziesiatki
    output [3:0] punkty3//setki
);
wire [3:0] dod1, dod2, dod3, dod4, dod5, dod6, dod7; // wyniki sum.
//czysto kombinacyjnie

add dodawanie1({1'b0, punktacja[7:5]}, dod1);//wejscie, wyjscie
add dodawanie2({dod1[2:0], punktacja[4]}, dod2);
add dodawanie3({dod2[2:0], punktacja[3]}, dod3);
add dodawanie4({dod3[2:0], punktacja[2]}, dod4);
add dodawanie5({dod4[2:0], punktacja[1]}, dod5);
add dodawanie6({1'b0,dod1[3],dod2[3],dod3[3]}, dod6);
add dodawanie7({dod6[2:0], dod4[3]}, dod7);

assign punkty1 = {dod5[2:0], punktacja[0]};//dla jednosci
assign punkty2 = {dod7[2:0], dod5[3]};//dla dziesiatek
assign punkty3 = {dod6[3], dod7[3]};//dla setek

endmodule