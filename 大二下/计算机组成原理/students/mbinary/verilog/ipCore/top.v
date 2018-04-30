`timescale 1ns / 1ps

module top(
    input           clk,
    input           rst_n,
    output  [31:0] oa,ob,oc
);
     assign oa = a,
        ob = b,
        oc = w;

wire [5:0]	rAddr, wAddr;
wire [31:0] w;
reg [31:0] a,b;
wire wEna;

control ctrl(clk,rst_n, wEna , rAddr,wAddr,ramr,a,b);

regfile  regfile(clk,rst_n,rAddr,rdata,wAddr,w,wEna);

alu alu(a,b,1,w);

ram ram1(clk,ena,1,wa,wd,clk,1,rAddr,ramr);
endmodule
