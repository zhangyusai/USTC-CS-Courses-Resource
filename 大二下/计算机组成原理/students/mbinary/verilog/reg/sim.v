`timescale 1ns / 1ps


module sim();

initial begin 
	$dumpfile("reg.vcd");
	$dumpvars(1,sim);
	end

 reg clk=0;
 reg [6:0] ct=0;
   reg rst_n = 1;
   wire [31:0] a,b,c;
    top top(clk,rst_n,a,b,c);
always #100 
    begin 
        if(ct==20) $finish;
        else begin 
        ct=ct+1 ;   
        clk=~clk; 
        
        end
    end 
always #200 $display("in sim: %g + %g = %g , At time %t", a,b,c,$time);
endmodule
