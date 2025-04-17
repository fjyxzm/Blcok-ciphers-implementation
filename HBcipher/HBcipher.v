`timescale   1ns/1ns
`define      N    63

module  HBcipher(result,a,k,clk);
    
    input  clk;
    input  [0:`N] a,k;
    output [0:`N] result;
    //output [0:`N] key;
    
    wire   [0:`N] te,r_key;
    reg    [0:`N] result;
    reg    [0:`N] key;
    reg    [ 0:7] cnt;
    reg    ready;
    
    initial  begin 
      cnt  <= 8'hff;
      ready<=1;
    end
    
    always @(posedge  clk)  begin
        
        cnt    <= (cnt^31)? cnt+1: cnt;
        result <= ready ? ( (cnt^8'hff)?te:a^k ):result;
        key <= ready ? ( (cnt^8'hff)?r_key:k ):k;
        ready  <= (cnt^31)? 1:0;
        $display(" cnt=%d ready=%d result=%x",cnt,ready,result);
    end
     
    HBcipher_r  hb_0(te, r_key,result,key,cnt);
      
endmodule
    
    
