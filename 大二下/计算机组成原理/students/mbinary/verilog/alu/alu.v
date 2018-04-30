

module alu(input signed  [31:0] alu_a,
		input signed  [31:0] alu_b,
		input 		  [4:0] alu_op,
		output 		  [31:0] alu_out);
		
		reg [31:0] res;
		assign alu_out = res;
		
		always@(*)
		begin
			case(alu_op)
			0:res=0;
			1:res=alu_a+alu_b;
			2:res=alu_a-alu_b;
			3:res=alu_a&alu_b;
			4:res=alu_a|alu_b;
			5:res=alu_a ^ alu_b;
			6:res= ~(alu_a|alu_b);
			default:res=0;
			endcase
		end
endmodule






