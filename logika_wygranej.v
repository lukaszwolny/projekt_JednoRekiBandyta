//punkty   komb
module logika_wygranej(
    input [2:0] symb1,
    input [2:0] symb2,
    input [2:0] symb3,
    input en,
    output reg [7:0] punkty
);
reg [2:0] symbol_wspolny;

//Kombinacyjnie
always@(*) begin
    
    punkty = 0;
    symbol_wspolny = 0;

    if(en) begin
         //3 takie same - maks (7 to maks)
        if((symb1 == symb2) && (symb2 == symb3)) begin
            case(symb1)
                3'd0: punkty = 10;
                3'd1: punkty = 15;
                3'd2: punkty = 20;
                3'd3: punkty = 25;
                3'd4: punkty = 30;
                3'd5: punkty = 60;
                3'd6: punkty = 100;
                3'd7: punkty = 200;
                default: punkty = 0;
            endcase
        end else if((symb1 == symb2) || (symb1 == symb3) || (symb2 == symb3)) begin
            //2 takie same - mniej
            if((symb1 == symb2) || (symb1 == symb3))
                symbol_wspolny = symb1;
            else
                symbol_wspolny = symb2;

            case(symbol_wspolny)
                3'd0: punkty = 3;
                3'd1: punkty = 5;
                3'd2: punkty = 7;
                3'd3: punkty = 10;
                3'd4: punkty = 15;
                3'd5: punkty = 20;
                3'd6: punkty = 25;
                3'd7: punkty = 30;
                default: punkty = 0;
            endcase
        end else begin
            //reszta - 0.
            punkty = 0;
        end
    end
end
endmodule