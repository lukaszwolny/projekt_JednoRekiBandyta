module wyswietlanie(
    input clk,
    input reset,
    input [2:0] s1, s2, s3,
    input [3:0] p1, p2, p3,
    input done,
    output [6:0] seg1,
    output [6:0] seg2,
    output [6:0] seg3
);

reg [3:0] Q;
reg [3:0] Q2;
reg [3:0] Q3;

always @(posedge clk) begin
    if (reset) begin
        Q <= 4'b0000;
        Q2 <= 4'b0000;
        Q3 <= 4'b0000;
    end else begin 
        if(done) begin
            Q <= p1;
            Q2 <= p2;
            Q3 <= p3;
        end else begin
            Q <= {1'b0, s1};
            Q2 <= {1'b0, s2};
            Q3 <= {1'b0, s3};
        end
    end
end

//Jeden do multipleksowania - artix
//wys_7seg dekoder(.znak(digit_value), .tryb(done), .seg(seg));

wys_7seg dekoder1(.znak(Q), .tryb(done), .seg(seg1));
wys_7seg dekoder2(.znak(Q2), .tryb(done), .seg(seg2));
wys_7seg dekoder3(.znak(Q3), .tryb(done), .seg(seg3));


endmodule