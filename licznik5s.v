module licznik5s(
    input clk,
    input reset,
    input en,
    input start,
    output reg done
);

reg [12:0] cnt;
//5s ale co 1ms czyli 5000 impulsow 1ms.
always@(posedge clk) begin
    if(reset) begin
        done <= 1'b0;
        cnt <= 1'b0;
    end 
    else begin
        if(start && !done) begin 
            //start aktywne jest
            if(en) begin
                //na kazdy en czyli 1ms
                if(cnt < 5000) begin
                    cnt <= cnt + 1'b1;
                    done <= 1'b0;
                end
                else begin
                    //cnt <= 16'd0;
                    done <= 1'b1;
                end
            end
        end
        else if(!start) begin
            cnt <= 13'd0;
            done <= 1'b0;
        end        
    end
end

endmodule