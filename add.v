module add(
    input [3:0] wej,
    output reg [3:0] wyj    
);

//jak liczna jest wieksza od 5 (>=5) to wtedy +3
always @(*) begin 
	case (wej)
        4'b0000: wyj = 4'b0000;//nie dodaje nic
        4'b0001: wyj = 4'b0001;//
        4'b0010: wyj = 4'b0010;
        4'b0011: wyj = 4'b0011;
        4'b0100: wyj = 4'b0100;
        4'b0101: wyj = 4'b1000;//>=5 wiec +3
        4'b0110: wyj = 4'b1001;
        4'b0111: wyj = 4'b1010;
        4'b1000: wyj = 4'b1011;
        4'b1001: wyj = 4'b1100;
        default: wyj = 4'b0000;
	endcase
end
endmodule