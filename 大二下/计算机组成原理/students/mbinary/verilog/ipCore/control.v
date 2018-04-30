`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:36 04/11/2018 
// Design Name: 
// Module Name:    control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module control(
	input clk,rst_n,
	//input [31:0] a,
	//input [31:0] b,
	input [31:0] aluout,
	output reg [5:0] ra=6'd0,//reg read addr
	input [31:0] rd,//reg read data
	output reg [5:0] wa=6'd0,
	output reg [31:0] wd,//reg write data
	output reg [31:0] td,//tmp data
	output reg ram_we,//reg write enable
	output reg [5:0] ram_ra,//reg read addr
	input [31:0] ram_rd//reg read data
    );
	reg [1:0] state=2'b11;//state变化3->0->1->2->2->2...
	always@(negedge clk) //下降沿改变数据(reg的we总为1，ram的we在读a,b之后开启)
		
		if(state==2'b11) 
			begin
				ram_ra<=6'b0;//从ram读a(改ram读地址为0，下一个上升沿将读ram[0]=a)
			end
		else if(state==2'b00) 
			begin
				wd<=ram_rd;//向reg写a(改写数据，下一个上升沿将写reg[0]=a)
				ram_ra<=6'b1;//从ram读b(改ram读地址为1，下一个上升沿将读ram[1]=b)
			end
		else if(state==2'b01)
			begin
				wd<=ram_rd;//向reg写b(改写数据，下一个上升沿将写reg[1]=b)
				td<=rd; //寄存前一个rd
			end
		else if(state==2'b10) 
			begin	
				wd<=aluout;//向reg,ram写aluout(改写数据为aluout，下一个上升沿将写reg,ram)
				td<=rd; //寄存前一个rd
				ram_we=1'b1;//开启ram的we从ram[2]开始写
			end
			
	always@(posedge clk or negedge rst_n) //上升沿改变地址
	begin
		if(~rst_n)//初始化
			begin
				wa<=6'd0;
				ra<=6'd0;
				state<=2'b11;
			end
		else
			begin
				if(state==2'b11)//这个状态下只有ram操作，reg不操作
					begin
						state<=2'b00;
					end
				else if(state==2'b00)//写a状态，reg读地址不+1，使reg读地址落后reg写地址一周期
					begin
						state<=2'b01;
						wa<=wa+6'd1;
					end
				else if(state==2'b01)//写b状态
					begin
						ra<=ra+6'd1;
						wa<=wa+6'd1;
						state<=2'b10;
					end
				else if(state==2'b10) //写aluout状态
					begin
						ra<=ra+6'd1;
						wa<=wa+6'd1;
					end
				
			end
	end

endmodule
