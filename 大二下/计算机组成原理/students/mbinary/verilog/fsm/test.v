module test();
    
reg clk=0,rst=0;

initial begin 
    $dumpfile("test.vcd");
    $dumpvars(0,test);
    #1000 ;
    $finish;
end

top top1(clk,rst);

always #10 
begin 
    clk = ~clk;
end


endmodule