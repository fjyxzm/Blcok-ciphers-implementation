`timescale    1ns/1ns
`define       K    79
`define       N    63

module  test;
    reg clk;
    reg [`N:0]  a;
    reg [`K:0]  k;
    wire [`N:0] result;
    
    initial  begin
     //a=64'h0123_4567_89AB_CDEF;
    // a<=64'h0000_0000_0000_0000;
    // k<=64'h0123_4567_89AB_CDEF;
     a <= 0;
     k <=  0;
     clk<=0;
     end

    always #10 clk=~clk;
    
    rectangle  rect(result,a,k,clk);
endmodule
	
