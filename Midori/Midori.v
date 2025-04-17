`timescale   1ns/1ns
`define      N    63
`define      K    127
module  Midori(result,a,k,clk);
    
    input  clk;
    input  [`N:0] a;
    input  [`K:0] k;
    output [`N:0] result;
    
    wire   [`N:0] te;
    reg    [`N:0] result;
    reg    [ 4:0] cnt;
    reg    ready;
    
    initial  begin 
      cnt  <= 5'h1f;
      ready<=1;
    end
    always @(posedge  clk)  begin
        
        cnt    <= (cnt^16)? cnt+1: cnt;
        result <= ready ? ( (cnt^5'h1f)?te:(a^k[127:64]^k[63:0])):result;
        ready  <= (cnt^16)? 1:0;
        $display(" cnt=%d ready=%d result=%x",cnt,ready,result);
    end
     
    MidoriRound_r  MR_0(te,result,k,cnt);
   // result=(result^k[127:64]^k[63:0]);
    
endmodule
    
    
