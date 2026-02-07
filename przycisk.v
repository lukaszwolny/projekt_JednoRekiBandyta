module przycisk(
	input clk,
	input btn,
	input reset,
	input reset_release,
	output reg btn_press,
	output reg btn_release
);

reg reset_release_prev;

always @(posedge clk)
begin
    reset_release_prev <= reset_release;
    
	if(reset)//& !btn_press        //reset   
	begin
		//reset wyjsc
		btn_press <= 1'b0;
		btn_release <= 1'b0;
	end
	else // dzialanie
	begin
		btn_press <= btn & ~btn_release;
		//teraz release:
		if(reset_release & ~reset_release_prev) begin   //reset_release
			btn_release <= 1'b0;
		end else begin
			if(btn_press & ~(btn & ~btn_release))
			begin
				btn_release <= 1'b1;
			end
		end
			
	end
end

endmodule