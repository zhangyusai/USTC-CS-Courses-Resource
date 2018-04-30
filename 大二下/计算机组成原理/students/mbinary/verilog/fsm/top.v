module top(
    input wire clk,
    input wire rst
    );
    
wire w_en,r_en;
wire [7:0] r_addr,w_addr;
wire [31:0] r_data,a,b,res;
wire [4:0] op;
alu alu1(a,b,op,res);
control ctrl1(clk,rst,w_en,w_addr,r_en,r_addr,r_data,a,b,op);
ram ram1(clk,w_en,1,w_addr,res,clk,r_en,r_addr,r_data);
endmodule


/* 
初始化,
检查control中的状态, 传给top, 前3个周期读,
此时也是通过control传递en, addr, 等信息,
将得到的输入信息传到control后,用导线?连接到alu,
alu再将计算结果传回control,
由control再写ram
 */


