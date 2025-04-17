`timescale   1ns/1ns
`define      N    63

module  LED(result,a,k,clk);
    
    input  clk;
    input  [`N:0] a,k;
    output [`N:0] result;
    
    wire   [`N:0] te;
    reg    [`N:0] result;
    reg    [ 7:0] cnt;
    reg    ready;
    
    initial  begin 
      cnt  <= 8'hff;
      ready<=1;
    end
    
    always @(posedge  clk)  begin
        
        cnt    <= (cnt^31)? cnt+1: cnt;
        result <= ready ? ( (cnt^8'hff)?te:a^k ):result;
        ready  <= (cnt^31)? 1:0;
        $display(" cnt=%d ready=%d result=%x",cnt,ready,result);
    end
     
    LEDRound_r  LR_0(te,    result,k,cnt);
      
endmodule
    
    
