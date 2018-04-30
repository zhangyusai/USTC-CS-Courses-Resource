module control(
    input clk,rst_n,
    output wEna,
    output [5:0] r1,w
    );
    reg  [5:0] ct =1;
    
    assign wEna = 1;
    assign  r1 = ct,
			w = ct+1;
    
    always@(posedge clk,negedge rst_n)
        begin
            if(~rst_n || ct==63) ct=1;
            else ct =ct+1;
        end
endmodule