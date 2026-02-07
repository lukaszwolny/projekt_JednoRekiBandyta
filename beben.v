module beben
#(parameter X_param = 2)
(
    input clk,
	input reset,
    input btn_press,
    input btn_release,

    input [2:0] val,
    output reg [2:0] symbol,
    output reg stop
);

reg [3:0] param;
reg [2:0] symbol_prev;
reg press_prev;
reg release_prev;

//timery
reg [31:0] timer_2s;
reg [19:0] timer_press;//20 bitow
reg [31:0] timer_select;
reg [31:0] timer;

reg licznik_done;

reg flaga_startu;


always@(posedge clk) begin
	if(reset)
	begin
		param <= 0;
        symbol_prev <= 0;
        press_prev <= 0;
        release_prev <= 0;
        
        symbol <= 3'b000; 
        stop <= 1'b0;//
        flaga_startu <= 1'b0;//Nie uruchomiono jeszcze


        timer <= 0;
        timer_select <= 2500000;//domyslna wartosc 
        //zerowanie timerow
        timer_2s <= 0;
        timer_press <= 0;
        licznik_done <= 0;

	end
	else begin
        press_prev <= btn_press;
        release_prev <= btn_release;
        
        //PRESS
        if(btn_press & ~press_prev) begin
            param <= X_param;//przepisanie parametru do rejestru roboczego
            timer_press <= 0;//resetowanie timera do zliczania czasu trzymiania przycisku
            stop <= 0;//resetowanie zatrzymania modułu. stop=1 oznacza że doliczył do konca juz
            flaga_startu <= 1'b1;//Uruchamianie;
        end else if(btn_press) begin
            if(timer_press < 1500000) timer_press <= timer_press + 1; //inkrementacja tego czasu
				else timer_press <= 0;
        end

        //param
        case (param)
            0, 1, 2: timer_select <= 2500000;//50ms
            3:       timer_select <= 10000000 + timer_press;//200ms 10000000 15000000 300ms
            4:       timer_select <= 25000000 + timer_press;//500ms
            default: timer_select <= 2500000;//50ms...
        endcase              

        //RELEASE
        if(btn_release & ~release_prev) begin
            timer_2s <= 100000000;//na początku ustaw max wartosci
        end else if(btn_release) begin
            if(timer_2s >= 100000000) begin
                timer_2s <= 0;//resetuj ten licznik 2s jak doliczy
                if(!stop) param <= param + 1;//jesli stop!=1, to inkrementuj param.
                if(param >= 4) begin//spr czy param juz nie jest = 5
                    stop <= 1;//jesli jest to koniec
                end else begin
                    stop <= 0;//jesli nie jest        
                end  
            end else begin
                timer_2s <= timer_2s + 1; // jesli nie jest rowny 2s no to inkrmentuj
            end
            //Reszta tutaj
        end else begin
            timer_2s <= 0;
        end

        //Licznik
        if(!stop && flaga_startu) begin
            if (timer < timer_select) begin
                timer <= timer + 1;//inkrementuj licznik aż do max value
                licznik_done <= 0;
            end else begin
                timer <= 0;//jeśli już doliczylo to zerowanie
                licznik_done <= 1;//i zapisanie symbolu
            end

            //stop - anty duplikacja symbolu
            if(licznik_done) begin  //!stop
                if(val == symbol_prev) begin
                    symbol <= val + 1;
                    symbol_prev <= val + 1; 
                end else begin
                    symbol <= val;
                    symbol_prev <= val;     
                end
            end
        end else begin
            licznik_done <= 0;
            timer <= 0;
            //tutaj symbol = symbol?
        end


	end
end

endmodule