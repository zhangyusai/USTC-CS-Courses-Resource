module regfile(
	input	clk,
	input rst_n,
	input [5:0] rAddr1,//读地址1
	input [5:0] wAddr,//写地址
	input [31:0] wDin,//写数据
	input wEna,//写使能
	output [31:0] rDout1//读数据1
);
	reg [31:0] data [0:63];
	integer i;
	assign rDout1=data[rAddr1];//读
	
	always@(posedge clk or rst_n)//写和复位
		if(~rst_n)
		begin
			data[0]=0;
			data[1]=0;
			for(i=2; i<64; i=i+1) data[i]<=0;
		end
		else
		begin
			if(wEna)
				data[wAddr]<=wDin;
		end
endmodule
