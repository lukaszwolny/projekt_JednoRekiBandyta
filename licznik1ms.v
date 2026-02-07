module licznik1ms(
    input clk,
    input reset,
    output reg out
);
//reg [15:0] cnt = 16'd0;
reg [15:0] cnt;
//50,000 - 1ms
always@(posedge clk) begin
    if(reset) begin
        cnt <= 1'b0;
        out <= 1'b0;
    end else begin
        if(cnt < 50000) begin  //50000
            cnt <= cnt + 1'b1;
            out <= 1'b0;
        end
        else begin
            cnt <= 16'd0;
            out <= 1'b1;
        end
    end
end

endmodule