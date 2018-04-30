`timescale 1ns / 1ps

module top(
    input           clk,
    input           rst_n,
    output  [31:0] oa,ob,oc
);


wire [5:0]	rAddr1, wAddr;
wire [31:0] rdata,w;
reg [31:0] tmp=0,sum = 2;
wire wEna;
reg [31:0] res=2;

control ctrl(clk,rst_n, wEna , rAddr1,wAddr);

regfile  regfile(clk,rst_n,rAddr1,rdata,wAddr,sum,wEna);
alu alu(tmp,rdata,1,w);
assign oa = tmp,
        ob = rdata,
        oc = res;
always @(posedge clk) res = w;
//always @*
//$display("in top: tmp,t,rdata,sum,w,raddr= %g,%g,%g,%g,%g",tmp,t,rdata,sum,w,rAddr1);
always @(negedge clk)
    begin 
        tmp <=rdata;
        sum <= w;
        
    end



endmodule
