module genlosowych(
    input clk,
	input reset,
    output reg [8:0] rand_val
);
//9bit max 511.

always@(posedge clk) begin
    //LFSR!!!
	if(reset)
    begin
        rand_val <= 9'd1;
		  //rand_val <= 9'd0;
    end
    else begin
        //rand_val <= rand_val + 1'b1;
        rand_val <= {rand_val[7:0], (rand_val[4] ^ rand_val[8])};
    end
end

endmodule