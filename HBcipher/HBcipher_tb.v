`timescale    1ns/1ns
`define       N    63

module  test1;
    reg clk;
    reg [0:`N]  a,k;
    
    wire [0:`N] result;
    
    initial  begin
     //a=64'h0123_4567_89AB_CDEF;
    // a<=64'h0000_0000_0000_0000;
    // k<=64'h0123_4567_89AB_CDEF;
     a <= 0;
     k <=  0;
     clk<=1;
     end

    always #1 clk=~clk;
    
    HBcipher hbcipher(result,a,k,clk);
endmodule
    
    