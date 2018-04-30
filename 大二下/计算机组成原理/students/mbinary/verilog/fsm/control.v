module control(
    input clk,rst,
    output reg  w_en,
    output reg [7:0] w_addr,
    output reg r_en,
    output reg [7:0] r_addr,
    input [31:0] r_data,
    output reg [31:0] a,b,
    output reg [4:0]op
    );
    
    /* port */
/* reg w_en,r_en;
reg [5:0] r_addr,w_addr;
reg [31:0] r_data,a,b;
reg [4:0] op; */

/* inner */
reg [7:0] addr1,addr2,addr3;
reg [3:0] cur_st = 0, next_st=0;// 1,2,3,4,5


always@(posedge clk or posedge rst)
begin
    if(rst)
        cur_st = 0;
    else 
        cur_st = next_st;
end

always@(*)
    case(cur_st)
        1:next_st=2;
        2:next_st=3;
        3:next_st=4;
        4:if(r_data==-1) next_st=0; else next_st=5;
        5:next_st=1;
        default:next_st = 1;
    endcase
    
always@(negedge clk or posedge rst)
    if(rst||cur_st==0)begin
        w_en<=0;
        r_en<=1;
        addr1<=0;
        addr2 <= 100;
        addr3<=200;
        r_addr<=0;
        w_addr<=0;
        a<=0;
        b<=0;
    end else if(cur_st==1) begin
        w_en<=0;
        r_en<=1;
        addr1 <= addr1+1;
        r_addr <= addr1;
     end else if (cur_st==2) begin
        w_en<=0;
        r_en<=1;
        addr1 <= addr1+1;
        r_addr <= addr1;
        a<=r_data;
    end else if (cur_st==3) begin
        w_en<=0;
        r_en<=1;
        addr2 <= addr2+1;
        r_addr <= addr2;
        b<=r_data;
    end else if (cur_st==4) begin
        w_en<=0;
        r_en<=0;
        op<=r_data;
    end else if(cur_st==5) begin
        w_en<=1;
        r_en<=0;
        addr3 = addr3+1;
        w_addr <= addr3;
    end
    
endmodule